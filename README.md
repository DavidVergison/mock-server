## Pourquoi ?

Un serveur de mock est un outil essentiel dans notre contexte de développement parallèle, où deux équipes travaillent simultanément sur les deux parties du système client/serveur. Le serveur de mock imite le comportement du vrai serveur en répondant aux requêtes du client avec des données prédéfinies et prévisibles. Cela permet à l'équipe de développement du client de travailler et de tester leur code même si le serveur réel n'est pas encore prêt ou disponible.

J'ai choisi [mockingjay-server](https://github.com/quii/mockingjay-server) pour sa simplicité de mise en oeuvre.


## Comment ?

lancement du serveur :
```sh
$ ./start.sh
mocking-jay: 2023/08/09 13:04:23 Listening on port 8080
2023/08/09 13:04:23 Monkey config loaded
2023/08/09 13:04:23  1% of the time | Body: This is wrong :(  
2023/08/09 13:04:23 20% of the time | Delay: 1s 
2023/08/09 13:04:23  2% of the time | Status: 500 
2023/08/09 13:04:23  1% of the time | Garbage bytes: 10000000
```

Test simple :
```sh
# correspond au fichier de configuration simple.yaml
$ curl "localhost:9876/hello"
```

Exemples d'api mock-és simple :
```sh
# correspond au fichier de configuration flex_var.yaml
$ curl "localhost:9876/hello/flexvar?a=b&c=yodelay"
$ curl "localhost:9876/hello/flexvar?a=b&c=heehoo"

# correspond au fichier de configuration flex_path.yaml
$ curl "localhost:9876/hello/flex/finishhim"
$ curl "localhost:9876/hello/flex/fatality"

# correspond au fichier de configuration headers.yaml
$ curl --header "x-api-key: xyz" "localhost:9876/hello"

# correspond au fichier de configuration other_verbs.yaml
$ curl -XPOST -d '{"message": "there"}' -H 'Content-Type: application/json' localhost:9876/hello
```
# Bonus

```sh
# renvoi la liste des requêtes recues par le serveur de mock
$ curl "localhost:9876/requests" | jq
[
  {
    "URI": "/hello",
    "Method": "GET",
    "Headers": {
      "accept": "*/*",
      "user-agent": "curl/7.81.0"
    },
    "Body": "",
    "Form": null
  },
  {
    "URI": "/hello",
    "Method": "GET",
    "Headers": {
      "accept": "*/*",
      "user-agent": "curl/7.81.0"
    },
    "Body": "",
    "Form": null
  }
]
```

