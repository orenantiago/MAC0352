/* Por Prof. Daniel Batista <batista@ime.usp.br>
 * Em 9/8/2017
 * 
 * Um código simples (não é o código ideal, mas é o suficiente para o
 * EP) de um servidor de eco a ser usado como base para o EP1. Ele
 * recebe uma linha de um cliente e devolve a mesma linha. Teste ele
 * assim depois de compilar:
 * 
 * ./servidor 8000
 * 
 * Com este comando o servidor ficará escutando por conexões na porta
 * 8000 TCP (Se você quiser fazer o servidor escutar em uma porta
 * menor que 1024 você precisa ser root).
 *
 * Depois conecte no servidor via telnet. Rode em outro terminal:
 * 
 * telnet 127.0.0.1 8000
 * 
 * Escreva sequências de caracteres seguidas de ENTER. Você verá que
 * o telnet exibe a mesma linha em seguida. Esta repetição da linha é
 * enviada pelo servidor. O servidor também exibe no terminal onde ele
 * estiver rodando as linhas enviadas pelos clientes.
 * 
 * Obs.: Você pode conectar no servidor remotamente também. Basta saber o
 * endereço IP remoto da máquina onde o servidor está rodando e não
 * pode haver nenhum firewall no meio do caminho bloqueando conexões na
 * porta escolhida.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <time.h>
#include <unistd.h>
#include <sys/stat.h>
#include <string.h>
#include <dirent.h> 
#include <fcntl.h>


#define LISTENQ 1
#define MAXDATASIZE 100
#define MAXLINE 4096
#define MAXUSERNAME 100
#define MAXPASSWORD 100
#define USER 0
#define PASS 1

char *known_commands[]= {"USER", "PASS", "SYST", "PASV", "LIST", "RETR", "STOR", "DELE", "QUIT"};
typedef struct user {
    char *name;
    char *password;
    char *home_dir;
} user;

typedef struct connection {
    user *current_user;
    int command_fd;
    int data_fd;
    char * dir;
} connection;


user* init_user() {
    user *current_user = (user*) malloc(sizeof(user*));
    current_user->name = (char*) malloc(MAXUSERNAME*sizeof(char));
    current_user->password = (char*) malloc(MAXPASSWORD*sizeof(char));
    current_user->home_dir = (char*) malloc(MAXPASSWORD*sizeof(char));
    return current_user;
}

connection* init_connection() {
    struct sockaddr_in servaddr;
    connection* current_connection = (connection*) malloc(sizeof(connection*));
    current_connection->current_user = init_user();  
    current_connection->dir = (char*) malloc(MAXPASSWORD*sizeof(char));  
    
    return current_connection;
}

char** split_buffer(char buffer[]) {
    char **command = (char**) malloc(2*sizeof(char*));
    command[0] = strtok(buffer," \n\r");
    command[1] = strtok(NULL," \n\r");
    return command;
}

int check_command(char *command) {
    for(int i = 0; i < sizeof(known_commands)/sizeof(known_commands[0]); i++) {
        if(strcmp(known_commands[i], command) == 0) {
            return i;
        }
    }
    return -1;
}

char* retr(connection *current_connection, char*filename) {
    int block_size;
    FILE *file;
    char *full_filename= (char*) malloc(sizeof(current_connection->dir) + sizeof(filename)+1);
    bzero(full_filename, sizeof(full_filename));
    strcat(full_filename, current_connection->dir);
    strcat(full_filename, "/");
    strcat(full_filename, filename);
    char databuf[MAXDATASIZE];

    current_connection->data_fd = accept(current_connection->data_fd, (struct sockaddr *) NULL, NULL);
    file = fopen(full_filename, "r");
    if(!file) {
        return "550 documento nao existe.\n";
    }
    while((block_size=fread(databuf, 1, MAXDATASIZE, file))>0) {
        if(send(current_connection->data_fd, databuf, block_size, 0) < 0) {
            return "550 teste.\n";
        }
        bzero(databuf, MAXDATASIZE);
    }
    fclose(file);
    close(current_connection->data_fd);
    return "226 transferencia completada.\n";
}

char* stor(connection *current_connection, char*filename) {
    int block_size;
    FILE *file;
    char *full_filename= (char*) malloc(sizeof(current_connection->dir) + sizeof(filename)+1);
    bzero(full_filename, sizeof(full_filename));
    strcat(full_filename, current_connection->dir);
    strcat(full_filename, "/");
    strcat(full_filename, filename);
    char databuf[MAXDATASIZE];

    current_connection->data_fd = accept(current_connection->data_fd, (struct sockaddr *) NULL, NULL);
    file = fopen(full_filename, "w");
    while((block_size=read(current_connection->data_fd, databuf, MAXDATASIZE)) > 0) {
        if(fwrite(databuf, 1, block_size, file) != block_size) {
            return "550 teste.\n";
        }
        bzero(databuf, MAXDATASIZE);
    }
    fclose(file);
    close(current_connection->data_fd);
    return "226 transferencia completada.\n";
}


char *interpret(connection *current_connection, char *command[]) {
    int command_code = check_command(command[0]);
    command[1][strcspn(command[1], "\r\n")] = 0;

    struct stat s;
    int result = -1;

    struct sockaddr_in servaddr;
    struct dirent *de; 
    DIR *dr;
    int flag;
    char *home_tmp = malloc(200);

    switch (command_code)
    {
    case 0: // USER
        strncpy(current_connection->current_user->name, command[1], strlen(command[1]));
        return "331\n";
    case 1: // PASSWORD
        strncpy(current_connection->current_user->password, command[1], strlen(command[1]));
        // current_user->home_dir = "/home/";
        strcat(current_connection->current_user->home_dir, current_connection->current_user->name);

        
        if(stat(current_connection->current_user->home_dir, &s) == 0 && S_ISDIR(s.st_mode)) {
            result = 0;
        } else {
            result = mkdir(current_connection->current_user->home_dir, 0777);
        }
        if(result != 0){
            printf("erro ao criar usuario, tente rodar o servidor como root");
            
            return "451 erro no servidor.\n";
        }
        strcpy(current_connection->dir, current_connection->current_user->home_dir);

        return "230 usuario logado.\n";
    case 2: // SYST
        return "215 Renan's ftp server.\n";
    
    case 3: // PASV
        //cria um socket connfd_data para a passagem de dados
        if ((current_connection->data_fd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
            perror("socket :(\n");
            exit(2);
        }

        srand(time(NULL));
        int a = rand() % (200 + 1 - 20);   
        int b = rand() % (200 + 1 - 20);   

        //setando o socket para passagem de dados
        bzero(&servaddr, sizeof(servaddr));
        servaddr.sin_family        = AF_INET;
        servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
        servaddr.sin_port          = htons(a * 256 + b);//htons(atoi("41964"));
        if (bind(current_connection->data_fd, (struct sockaddr *)&servaddr, sizeof(servaddr)) == -1) {
            perror("bind :(\n");
            exit(3);
        }
        char *message = malloc(200);
        sprintf(message, "227 passive mode (127,0,0,1,%d,%d)\n", a, b);
        //ouve o connfd_data
        listen(current_connection->data_fd, 5);
        return message;
        // return "227 passive mode (127,0,0,1,100,240)\n";
    case 4: // LIST
        strcpy(home_tmp, "./");
        strcat(home_tmp, current_connection->current_user->home_dir);
        dr = opendir(home_tmp); 
        if (dr == NULL){ 
            return "551 Não foi possível abrir o diretório\n"; 
        } 
        de = readdir(dr);
        while (de != NULL){
            //para não listar o mesmo diretório ou o diretório pai
            if (strcmp(de->d_name, ".") != 0 && strcmp(de->d_name, "..") != 0){
                // write(connfd, de->d_name, strlen(de->d_name));
                dprintf(current_connection->command_fd, "%s %s", de->d_name, " "); 
            }                
            de = readdir(dr);
        }
        closedir(dr);     
        return "226 listagem dos arquivos completa\n";
    case 5: // RETR
        message = "150 abrindo a conexao binaria que existe entre nos (vem de zap).\n";
        write(current_connection->command_fd, message, strlen(message));
        return retr(current_connection, command[1]);

    case 6: // STOR
        message = "150 abrindo a conexao binaria que existe entre nos (vem de zap).\n";
        write(current_connection->command_fd, message, strlen(message));
        return stor(current_connection, command[1]);
    case 7:
        //comand[1] é o argumento
        // printf("COMANDO: %s", command[1]);
        strcpy(home_tmp, "./");
        strcat(home_tmp, current_connection->current_user->home_dir);
        strcat(home_tmp, "/");
        strcat(home_tmp, command[1]);
        flag = remove(home_tmp);
        if (flag == 0){
            return "250 deleção concluída\n";
        }
        else{
            return "550 não foi possível realizar a deleção\n";
        }

        return "226 e ai xuxu\n";
    case 8:
        return "221 conexão encerrada. Pensei que fossemos amigos..\n";
        close(current_connection->data_fd);
        
    case -1:
        return "502 comando nao implementado.\n";
        break;
    }
    
}

int main (int argc, char **argv) {
    /* Os sockets. Um que será o socket que vai escutar pelas conexões
    * e o outro que vai ser o socket específico de cada conexão */
    int listenfd, connfd;
    /* Informações sobre o socket (endereço e porta) ficam nesta struct */
    struct sockaddr_in servaddr;
    /* Retorno da função fork para saber quem é o processo filho e quem
    * é o processo pai */
    pid_t childpid;
    /* Armazena linhas recebidas do cliente */
    char     recvline[MAXLINE + 1];
    /* Armazena o tamanho da string lida do cliente */
    ssize_t  n;
    
    if (argc != 2) {
        fprintf(stderr,"Uso: %s <Porta>\n",argv[0]);
        fprintf(stderr,"Vai rodar um servidor de echo na porta <Porta> TCP\n");
        exit(1);
    }

    /* Criação de um socket. Eh como se fosse um descritor de arquivo. Eh
    * possivel fazer operacoes como read, write e close. Neste
    * caso o socket criado eh um socket IPv4 (por causa do AF_INET),
    * que vai usar TCP (por causa do SOCK_STREAM), já que o FTP
    * funciona sobre TCP, e será usado para uma aplicação convencional sobre
    * a Internet (por causa do número 0) */
    if ((listenfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket :(\n");
        exit(2);
    }

    /* Agora é necessário informar os endereços associados a este
     * socket. É necessário informar o endereço / interface e a porta,
     * pois mais adiante o socket ficará esperando conexões nesta porta
     * e neste(s) endereços. Para isso é necessário preencher a struct
     * servaddr. É necessário colocar lá o tipo de socket (No nosso
     * caso AF_INET porque é IPv4), em qual endereço / interface serão
     * esperadas conexões (Neste caso em qualquer uma -- INADDR_ANY) e
     * qual a porta. Neste caso será a porta que foi passada como
     * argumento no shell (atoi(argv[1]))
     */
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family        = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port          = htons(atoi(argv[1]));
    if (bind(listenfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) == -1) {
        perror("bind :(\n");
        exit(3);
    }

    /* Como este código é o código de um servidor, o socket será um
     * socket passivo. Para isto é necessário chamar a função listen
     * que define que este é um socket de servidor que ficará esperando
     * por conexões nos endereços definidos na função bind. */
    if (listen(listenfd, LISTENQ) == -1) {
        perror("listen :(\n");
        exit(4);
    }

    printf("[Servidor no ar. Aguardando conexoes na porta %s]\n",argv[1]);
    printf("[Para finalizar, pressione CTRL+c ou rode um kill ou killall]\n");
    
    /* O servidor no final das contas é um loop infinito de espera por
     * conexões e processamento de cada uma individualmente */
    for (;;) {
        /* O socket inicial que foi criado é o socket que vai aguardar
         * pela conexão na porta especificada. Mas pode ser que existam
         * diversos clientes conectando no servidor. Por isso deve-se
         * utilizar a função accept. Esta função vai retirar uma conexão
         * da fila de conexões que foram aceitas no socket listenfd e
         * vai criar um socket específico para esta conexão. O descritor
         * deste novo socket é o retorno da função accept. */
        if ((connfd = accept(listenfd, (struct sockaddr *) NULL, NULL)) == -1 ) {
                perror("accept :(\n");
                exit(5);
        }
        
        /* Agora o servidor precisa tratar este cliente de forma
         * separada. Para isto é criado um processo filho usando a
         * função fork. O processo vai ser uma cópia deste. Depois da
         * função fork, os dois processos (pai e filho) estarão no mesmo
         * ponto do código, mas cada um terá um PID diferente. Assim é
         * possível diferenciar o que cada processo terá que fazer. O
         * filho tem que processar a requisição do cliente. O pai tem
         * que voltar no loop para continuar aceitando novas conexões */
        /* Se o retorno da função fork for zero, é porque está no
         * processo filho. */
        if ( (childpid = fork()) == 0) {
            /**** PROCESSO FILHO ****/
            printf("[Uma conexao aberta]\n");

            /* Já que está no processo filho, não precisa mais do socket
             * listenfd. Só o processo pai precisa deste socket. */
            close(listenfd);
            
            /* Agora pode ler do socket e escrever no socket. Isto tem
             * que ser feito em sincronia com o cliente. Não faz sentido
             * ler sem ter o que ler. Ou seja, neste caso está sendo
             * considerado que o cliente vai enviar algo para o servidor.
             * O servidor vai processar o que tiver sido enviado e vai
             * enviar uma resposta para o cliente (Que precisará estar
             * esperando por esta resposta) 
             */

            /* ========================================================= */
            /* ========================================================= */
            /*                                 EP1 INÍCIO                                */
            /* ========================================================= */
            /* ========================================================= */
            /* TODO: É esta parte do código que terá que ser modificada
             * para que este servidor consiga interpretar comandos FTP    */

            //fazer um login
            //mandar o cliente se conectar nessa porta de dados (8020)
            //o cliente se conecta nessa porta de dados
            //dependendo da requisição do cliente, uma ação diferente
            //roteiro:
            //1. o cliente loga com qualquer username e senha
            //2. o servidor redireciona o cliente
            //  caso já exista, redireciona para pasta existente
            //  cc, cria um novo diretório
            //3. 
            //4.
            //5.
            //6.
            //7.
            //8.
            //9.
            //10.

            //usuários com no máximo 100 caracteres
            char buffer[MAXDATASIZE];
            user *current_user = init_user();
            connection *current_connection= init_connection();
            current_connection->command_fd = connfd;
            char **command;
            int n, command_value, datafd;
            struct sockaddr_in servaddr_passive;
            write(connfd, "220 bem vindo :)\n", strlen("220 bem vindo :)\n"));
            while(n = read(connfd, buffer, MAXLINE) > 0) {
                command = split_buffer(buffer);
                char *command_return = interpret(current_connection, command);
                write(connfd, command_return, strlen(command_return));
            }
            // write(connfd, "220 bem vindo :)\n", strlen("220 bem vindo :)\n"));
            // while(n = read(connfd, buffer, 100) > 0) {
            //     fputs(buffer, stdout);
            // }
            // }
            // login(&connfd);
            // char username_tmp[MAXUSERNAME];
            // for(;;) {
            //     if(recv(connfd, username_tmp, MAXUSERNAME, 0) != -1) {
            //         fputs(username_tmp, stdout);
            //     }
            // }
            // char username[MAXUSERNAME];            
            // strncpy(username, username_tmp, strlen(username_tmp) - 2);         

            //senhas com no máximo 100 caracteres
            // char insert_password[] = "Insira sua senha: ";
            // write(connfd, insert_password, strlen(insert_password));
            // char password_tmp[MAXPASSWORD];
            // n = read(connfd, password_tmp, MAXPASSWORD);
            // fputs(password_tmp, stdout);
            // char password[MAXUSERNAME];            
            // strncpy(password, password_tmp, strlen(password_tmp) - 2);

            //se o username tiver um diretório, abrimos ele, caso contrário, criamos um
            // char path[] = "./users/";
            // strcat(path, username);
            // int result = mkdir(path, 0777);

            // while (write(connfd, "<SERVIDOR FTP>: ", strlen("<SERVIDOR FTP>: ")) && (n=read(connfd, recvline, MAXLINE)) > 0) {
            //     recvline[n]=0;
            //     printf("[Cliente conectado no processo filho %d enviou:] ",getpid());
            //     if ((fputs(recvline,stdout)) == EOF) {
            //         perror("fputs :( \n");
            //         exit(6);
            //     }
            //     write(connfd, recvline, strlen(recvline));
            // }
            /* ========================================================= */
            /* ========================================================= */
            /*                                 EP1 FIM                                    */
            /* ========================================================= */
            /* ========================================================= */

            /* Após ter feito toda a troca de informação com o cliente,
             * pode finalizar o processo filho */
            printf("[Uma conexao fechada]\n");
            exit(0);
        }
        /**** PROCESSO PAI ****/
        /* Se for o pai, a única coisa a ser feita é fechar o socket
         * connfd (ele é o socket do cliente específico que será tratado
         * pelo processo filho) */
            close(connfd);
    }
    exit(0);
}
