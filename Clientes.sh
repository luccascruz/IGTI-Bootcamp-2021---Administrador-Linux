#
# Autor: Luccas Monteiro Cruz
#---------------------------------------------#

#### Variaveis ###
CLIENTES="/root/clientes"

#### Funcoes #####
uso () {
    echo
    echo "Parametros aceitos 1, 2, ou 3:
    1) Consultar
    2) Adicionar
    3) Remover" ; echo

    echo "Exemplo: $0 1" ; echo
    exit
}


consultar () {
    echo
    echo "### CONSULTAR CLIENTES ###"
    echo
        # Se encontrar algum cliente
    if [[ `ls $CLIENTES 2> /dev/null` ]]
    then
        echo -e "Listando os clientes cadastrados...\n"
        ls -d $CLIENTES
        read -p 'Informe o nome da empresa que deseja CONSULTAR o contato: ' _CONSULTA
        echo -e 'Consultando o contato do cliente...\n'
        echo -e '============================\n'
        cat "$CLIENTES/$_CONSULTA/cliente.txt" 
        echo -e '============================\n'
    else
        echo "Não existe nenhum cliente cadastrado!"
    fi
}

adicionar () {
    echo
    echo "### ADICIONAR CLIENTE ###"
    echo
    read -p 'EMRPESA: ' _EMPRESA
    read -p 'CLIENTE: ' _CLIENTE
    read -p 'TELEFONE: ' _TELEFONE

    echo -e "### Criando o diretorio $CLIENTES/$_EMPRESA ###\n"
    mkdir -p "$CLIENTES/$_EMPRESA"
    
    echo -e "### Salvando contato do cliente em $CLIENTES/$_EMPRESA/cliente.txt ###\n"
    echo -e "NOME: $_CLIENTE\nTELEFONE: $_TELEFONE" >> "$CLIENTES/$_EMPRESA/cliente.txt"  
}

remover () {
    echo
    echo "### REMOVER CLIENTE ###"
    echo
    echo "Listando os clientes cadastrados..."
    ls $CLIENTES
    read -p 'Informe o nome da empresa que deseja REMOVER:' _REMOVE
    echo -e "Removendo o cliente $_REMOVE ...\n"
    echo -e "O diretório /root/clientes/$_REMOVE será removido...\n"
    rm -rf "$CLIENTES/$_REMOVE" 
    echo -e "Removido!\n"

    
}


#### Verificacoes ####
# $# => conta a quantidade de parametros
# Quantidade de parametros diferente de 1 ?
if [ "$#" -ne 1 ]
then
    echo
    echo "*** Obrigatorio informar um parametro ***"
    uso # Chamada da funcao "uso"
fi

#### Execucao ####
# Chamada das funcoes principais
case $1 in
    1)
    consultar ;;

    2)
    adicionar ;;

    3)
    remover ;;

    *)
    uso ;;
esac
