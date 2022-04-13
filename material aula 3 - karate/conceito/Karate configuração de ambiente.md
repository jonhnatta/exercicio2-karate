![Logo Raro Academy](../logo.jpeg)

# Karate - Configuração de ambiente

- [Karate - Configuração de ambiente](#karate---configuração-de-ambiente)
  - [1. O que é o ambiente](#1-o-que-é-o-ambiente)
  - [2. Como configurar](#2-como-configurar)
    - [2.1. Configurando a baseUrl](#21-configurando-a-baseurl)
    - [2.2. Configurando *headers* para todas as requisições](#22-configurando-headers-para-todas-as-requisições)
    - [2.3. Configurando e formatando os logs](#23-configurando-e-formatando-os-logs)
    - [2.4. Configurações de rede](#24-configurações-de-rede)
    - [2.5. Configuração de tempo de conexão das requisições](#25-configuração-de-tempo-de-conexão-das-requisições)
    - [2.6. Configuração de tempo de resposta das requisições](#26-configuração-de-tempo-de-resposta-das-requisições)
    - [2.7. Adicionando lógica na configuração de ambiente](#27-adicionando-lógica-na-configuração-de-ambiente)
  - [3. Enviando parâmetros via linha de comando](#3-enviando-parâmetros-via-linha-de-comando)
    - [3.1. Enviando parâmetro de environment](#31-enviando-parâmetro-de-environment)
    - [3.2. Selecionando um teste para ser executado através do nome do cenário](#32-selecionando-um-teste-para-ser-executado-através-do-nome-do-cenário)
    - [3.3. Executar um teste sem armazenar logs](#33-executar-um-teste-sem-armazenar-logs)
    - [3.4. Configurar o local do arquivo de configuração](#34-configurar-o-local-do-arquivo-de-configuração)
  - [4. Dicionário](#4-dicionário)
  - [5. Referências](#5-referências)

## 1. O que é o ambiente

O ambiente no contexto de automação de testes se trata de uma configuração de execução dos testes que define alguns parâmetros como:

- Definição da aplicação a ser testada;
- Url da aplicação;
- Nome da aplicação;
- Autenticação de rede;
- Configurações de chamada HTTP;
- Configurações do framework.

## 2. Como configurar

O Karate Framework permite que as configurações de teste sejam realizadas em um arquivo chamado ``karate-config.js`` que, por padrão, deve ser criado na pasta ``raiz`` do projeto de testes.

> O local do arquivo de configuração pode ser alterado enviando o parametro -g na linha de comando.

Conforme podemos ver, a extensão do arquivo é ``.js``, logo, a configuração do Karate deve ser feita com a linguagem *JavaScript*.

Neste arquivo de configuração deve ser criado uma ``function`` que deverá realizar e exportar a configuração para o restante do projeto.

>Criando uma função de setup para o karate-config.js
```javascript
function setup() {
    var config = {}

    return config;
}
```

Todas as variáveis criadas nesta função ``setup`` serão carregadas pelo Karate e disponibilizadas para uso em todos os arquivos de feature, onde os testes são definidos.

Deste forma, é possível configurar informações relevantes para o teste como, por exemplo, a ``baseUrl`` para as requisições, através de variáveis criadas no arquivo de configuração.

### 2.1. Configurando a baseUrl

```javascript
function setup() {
    var config = {
        baseUrl: "https://petstore.swagger.io/v2"
    }

    return config;
}
```

### 2.2. Configurando *headers* para todas as requisições
```javascript
function setup() {
    karate.configure("headers", {
        secret: "ak109sa1kj-amsasuil1"
    })
}
```

### 2.3. Configurando e formatando os logs

Por padrão, os logs do Karate são todos ``minified``, ou seja, reduzidos.

Podemos alterar este comportamento padrão adicionando as configurações abaixo:

- ``logPrettyRequest``: formata os logs de *request* enviadas pelo Karate;
- ``logPrettyResponse``: formata os logs de *response*.

```javascript
function setup() {
    karate.configure("logPrettyRequest", true);
    karate.configure("logPrettyResponse", true);
}
```
### 2.4. Configurações de rede

É possível configurar dados de acesso como, por exemplo, o ``proxy`` de internet. Esta configuração é muito útil quando o ambiente de testes se encontra em um local de rede com controle de acesso restrito.

```javascript
function setup() {
    karate.configure("proxy", URL_DO_PROXY);
}
```

### 2.5. Configuração de tempo de conexão das requisições

O karate possibilita que seja configurado um tempo máximo de conexão com o servidor. O valor padrão é de ``30000 milisegundos``, ou seja, 30 segundos.

Podemos alterar este valor, por exemplo, para 60 segundos.

Neste cenário, se uma request demorar mais de 60 segundos para ser aceita pelo servidor, o Karate irá interromper o teste e marcará um erro.

```javascript
function setup() {
    karate.configure("connectTimeout", 60000);
}
```

### 2.6. Configuração de tempo de resposta das requisições

O karate possibilita que seja configurado um tempo máximo para aguardar a resposta do servidor. O valor padrão é de ``30000 milisegundos``, ou seja, 30 segundos.

Podemos alterar este valor, por exemplo, para 60 segundos.

Neste cenário, se uma response demorar mais de 60 segundos para ser devolvida, o Karate irá interromper o teste e marcará um erro.

```javascript
function setup() {
    karate.configure("readTimeout", 60000);
}
```

### 2.7. Adicionando lógica na configuração de ambiente

Como o código de configuração é escrito em *JavaScript*, é possível adicionar lógica e condições para realizar algumas configurações. 

Isto é muito útil quando temos informações que podem variar, como por exemplo, url da aplicação, algo muito comum quando existe mais de uma versão da aplicação que será testada.

No exemplo abaixo temos uma estrutura condicional (``if`` e ``else``) que faz a verificação de qual é o ``environment`` sendo utilizado no disparo do teste. Se o environment for ``prod``, a ``baseUrl`` será configurada com determinado endereço, senão será configurada com o outro endereço.

```javascript
function setup() {
    var env = karate.env;

    var config = {}

    if(env === "prod") {
        config.baseUrl = URL_DA_APLICACAO_EM_PRODUCAO
    } else {
        config.baseUrl = URL_DA_APLICACAO_EM_DESENVOLVIMENTO
    }

    return config;
}
```

## 3. Enviando parâmetros via linha de comando

Ao executar o ``standalone`` do Karate podemos ver um retorno com várias configurações que podem ser feitas no momento do teste.

```cli
java -jar karate.jar
```

Resultado: 
```
[main]  INFO  com.intuit.karate - Karate version: 1.1.0
Usage: <main class> [-CDhsSW] [-d[=<debugPort>]] [-c=<cert>] [-e=<env>]
                    [-g=<configDir>] [-i=<importFile>] [-j=<jobServerUrl>]
                    [-k=<key>] [-n=<name>] [-o=<output>] [-p=<port>]
                    [-P=<prefix>] [-T=<threads>] [-w=<workingDir>] [-f=<formats>
                    [,<formats>...]]... [-H=<hookFactoryClassNames>[,
                    <hookFactoryClassNames>...]]... [-m=<mocks>[,
                    <mocks>...]]... [-t=<tags>]... [<paths>[$<paths>...]...]
      [<paths>[$<paths>...]...]
                            one or more tests (features) or search-paths to run
  -c, --cert=<cert>         ssl certificate (default: cert.pem)
  -C, --clean               clean output directory
  -d, --debug[=<debugPort>] debug mode (optional port else dynamically chosen)
  -D, --dryrun              dry run, generate html reports only
  -e, --env=<env>           value of 'karate.env'
  -f, --format=<formats>[,<formats>...]
                            comma separate report output formats. tilde
                              excludes the output report. html report is
                              included by default unless it's negated.e.g. '-f
                              json,cucumber:json,junit:xml. Possible values
                              [html: Karate HTML, json: Karate JSON, cucumber:
                              json: Cucumber JSON, junit:xml: JUnit XML]
  -g, --configdir=<configDir>
                            directory where 'karate-config.js' is expected
                              (default 'classpath:' or <workingdir>)
  -h, --help                display this help message
  -H, --hook=<hookFactoryClassNames>[,<hookFactoryClassNames>...]
                            class name of a RuntimeHook (or RuntimeHookFactory)
                              to add
  -i, --import=<importFile> import and convert a file
  -j, --jobserver=<jobServerUrl>
                            job server url
  -k, --key=<key>           ssl private key (default: key.pem)
  -m, --mock, --mocks=<mocks>[,<mocks>...]
                            one or more mock server files
  -n, --name=<name>         scenario name
  -o, --output=<output>     directory where logs and reports are output
                              (default 'target')
  -p, --port=<port>         server port (default 8080)
  -P, --prefix=<prefix>     mock server path prefix (context-path)
  -s, --ssl                 use ssl / https, will use 'cert.pem' and 'key.pem'
                              if they exist in the working directory, or
                              generate them
  -S, --serve               app server using --workdir (experimental)
  -t, --tags=<tags>         cucumber tags - e.g. '@smoke,~@skipme' [@ignore is
                              always skipped by default]
  -T, --threads=<threads>   number of threads when running tests
  -w, --workdir=<workingDir>
                            working directory, defaults to '.'
  -W, --watch               watch (and hot-reload) mock server file for changes
```

### 3.1. Enviando parâmetro de environment

Basta enviar a flag ``-e`` ou ``--env`` no momento de executar o ``standalone``.

O valor da flag environment será repassado para o arquivo de configuração e poderá ajudar no ``setup`` do ambiente através da lógica adicionada, conforme visto em [2.7. Adicionando lógica na configuração de ambiente](#27-adicionando-lógica-na-configuração-de-ambiente)

``java -jar karate.jar *.feature -e=prod``

``java -jar karate.jar *.feature --env=prod``

### 3.2. Selecionando um teste para ser executado através do nome do cenário

Basta enviar a flag ``-n`` ou ``--name``

``java -jar karate.jar *.feature -n="Cadastrar usuário"``

``java -jar karate.jar *.feature --name="Cadastrar usuário"``

### 3.3. Executar um teste sem armazenar logs

Esta configuração diz ao Karate para não se preocupar com registro de log dos testes. 

Isto aumenta a performance do Karate e os testes serão executados de forma razoavelmente mais rápida. No entanto, isto afeta o comportamento de geração do relatório, já que não será possível verificar as informações de request e response.

Basta enviar a flag ``-D`` ou ``--dryrun``

``java -jar karate.jar *.feature -D``

``java -jar karate.jar *.feature --dryrun``

### 3.4. Configurar o local do arquivo de configuração

Esta configuração permite alterar o local padrão onde o arquivo ``karate-config.js`` está armazenado

Basta enviar a flag ``-g`` ou ``--configdir``

``java -jar karate.jar *.feature -g=localArquivo``

``java -jar karate.jar *.feature -g=localArquivo``

## 4. Dicionário

1. **Flag:** bandeira/marcação;
2. **Setup:** configuração;
3. **Proxy:** termo utilizado para definir a aplicação intermediária entre cliente e servidor. Utilizado para aumentar a segurança de recursos de rede/internet de organizações;
4. **Config:** configuração;
5. **Return:** retorno;
6. **connectTimeout:** tempo máximo de conexão;
7. **readTimeout:** tempo máximo de resposta;
8. **milissegundo:** a milésima parte de um segundo. 1 segundo = 1000 milisegundos;
9. **secret:** segredo;
10. **dry**: seco;
11. **run**; correr/rodar.

## 5. Referências

[Karate configure](https://github.com/karatelabs/karate#configure)

[karate-config.js - Doc](https://github.com/karatelabs/karate#karate-configjs)