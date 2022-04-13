![Logo Raroacademy QA](../logo.jpeg)

# Exercício de fixação Karate - Configuração de ambiente

Considerando que você criou o repositório ``exercicio2-karate``, no exercício de fixação 2, faça o seguinte:

1. Crie e migre para uma nova branch
    1. Abra o terminal do ``VsCode``;
    2. Crie uma nova branch chamada ``implementacao-ambiente`` executando o código a seguir no terminal: ``git checkout -b implementacao-ambiente``.

2. Crie um arquivo de configuração do Karate ``karate-config.js`` e neste arquivo faça a seguinte configuração:
    1. Adicione 2 novos headers para todas as requisições: 
        1. Header ``operador``, que deve ter o valor igual ao seu primeiro nome;
        2. Header ``framework``, que deve ter valor igual à ``karate``;
    2. Configure o tempo máximo de resposta das requisições para 40 segundos;
    3. Configure a ``baseUrl`` para todos os seus testes no arquivo de configuração;
    4. Crie uma condição que verifique se o environment enviado no disparo dos testes do karate é igual à ``dev`` e, caso positivo, adicione as configurações ``logPrettyRequest`` e ``logPrettyResponse`` como ``true``.

3. Altere os testes de ``user`` para utilizar ``baseUrl`` configurada em ``karate-config.js``

3. Atualize seu trabalho no Github através dos comandos:

- ``git add . ``
- ``git commit -m "MENSAGEM_DE_SUA_PREFERENCIA``
``git push``