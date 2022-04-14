Feature: Gestão de usuários 
    Como um gestor da Pet Store 
    Desejo gerenciar os usuários 
    Para ter o controle das informações cadastradas

    Background: Base url 
        Given url baseUrl
        And path "user"
        * def userId = "13"
        * def userName = "elidab"
        * def userNameUpdate = "elidag"
        * def payload = { id: 13, username: "elidab", firstName: "Élida", lastName: "Gonçalves", email: "elidab@example.com", password: "1234", phone: "9999-9999", userStatus: 0 }
        * def payloadUpdate = { id: 14, username: "elidag", firstName: "Élida", lastName: "Gonçalves", email: "elidag@example.com", password: "4321", phone: "8888-8888", userStatus: 0 }

    Scenario: Cadastrar um novo usuário
        And request payload
        When method post
        Then status 200
        # And match response contains { code, type, message }
        And match response contains { code: 200, type: "unknown", message: "#(userId)"}

    Scenario: Consultar usuário cadastrado pelo username
        And path userName
        When method get
        Then status 200
        And match response contains payload

    Scenario: Atualizar informações do usuário cadastrado
        And path userName
        And request payloadUpdate
        When method put
        Then status 200

        Given path "user"
        And path userNameUpdate
        When method get
        Then status 200
        And match response contains payloadUpdate

