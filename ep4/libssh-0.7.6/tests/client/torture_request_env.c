/*
 * This file is part of the SSH Library
 *
 * Copyright (c) 2013 by Andreas Schneider <asn@cryptomilk.org>
 *
 * The SSH Library is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or (at your
 * option) any later version.
 *
 * The SSH Library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with the SSH Library; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
 * MA 02111-1307, USA.
 */

#define LIBSSH_STATIC

#include "torture.h"
#include <libssh/libssh.h>

#include <errno.h>
#include <sys/types.h>
#include <pwd.h>

static int sshd_setup(void **state)
{
    torture_setup_sshd_server(state);

    return 0;
}

static int sshd_teardown(void **state) {
    torture_teardown_sshd_server(state);

    return 0;
}

static void setup(void **state)
{
    ssh_session session;
    struct passwd *pwd;

    pwd = getpwnam("bob");
    assert_non_null(pwd);
    setuid(pwd->pw_uid);

    session = torture_ssh_session(TORTURE_SSH_SERVER,
                                  NULL,
                                  TORTURE_SSH_USER_ALICE,
                                  NULL);

    assert_false(session == NULL);
    *state = session;
}

static void teardown(void **state)
{
    ssh_session session = *state;

    assert_false(session == NULL);

    if (ssh_is_connected(session)) {
            ssh_disconnect(session);
    }
    ssh_free(session);
}

static void torture_request_env(void **state)
{
    ssh_session session = *state;
    ssh_channel c;
    char buffer[4096] = {0};
    int nbytes;
    int rc;
    int lang_found = 0;

    c = ssh_channel_new(session);
    assert_non_null(c);

    rc = ssh_channel_open_session(c);
    assert_int_equal(rc, SSH_OK);

    rc = ssh_channel_request_env(c, "LC_LIBSSH", "LIBSSH");
    assert_int_equal(rc, SSH_OK);

    rc = ssh_channel_request_exec(c, "bash -c export");
    assert_int_equal(rc, SSH_OK);

    nbytes = ssh_channel_read(c, buffer, sizeof(buffer) - 1, 0);
    while (nbytes > 0) {
#if 0
        rc = fwrite(buffer, 1, nbytes, stdout);
        assert_int_equal(rc, nbytes);
#endif
        buffer[nbytes]='\0';
        if (strstr(buffer, "LC_LIBSSH=\"LIBSSH\"")) {
            lang_found = 1;
            break;
        }

        nbytes = ssh_channel_read(c, buffer, sizeof(buffer), 0);
    }
    assert_int_equal(lang_found, 1);

    ssh_channel_close(c);
}

int torture_run_tests(void) {
    int rc;
    struct torture_state *s = NULL;

    UnitTest tests[] = {
        unit_test_setup_teardown(torture_request_env, setup, teardown),
    };

    ssh_init();

    torture_filter_tests(tests);
    sshd_setup((void **)&s);
    rc = run_tests(tests);
    sshd_teardown((void **)&s);

    ssh_finalize();
    return rc;
}

