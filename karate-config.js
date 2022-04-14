
function setup() {

  var config = {
    baseUrl: "https://petstore.swagger.io/v2"
  }
  
  var env = karate.env

  karate.configure("headers", {
    operador: "Jonhnatta",
    framework: "karate"
  })

  karate.configure("connectTimeout", 40000);

  if(env == "dev") {
    karate.configure("logPrettyRequest", true);
    karate.configure("logPrettyResponse", true);
  }

  return config
}
