[Website](http://rendas.improvecoimbra.org/) (beta)

## Sobre ##

Este website permite recolher informação sobre as rendas dos quartos e casas de Coimbra. O objectivo é fornecer dados e estatísticas sobre os preços das rendas, que ajudem os cidadãos a tomar melhores decisões e analisar a realidade imobiliária da cidade.

Este é um projecto desenvolvido no [Improve Coimbra](http://improvecoimbra.org/), um evento mensal com o objectivo de encontrar e implementar soluções para melhorar Coimbra.

## Desenvolvimento ##

Informações importantes sobre esta aplicação/repositório.

### Tecnologias ###

* Ruby on Rails
* MongoDB
* SASS (CSS)
* jQuery (Javascript)

### Produção ###

Para a execução desta aplicação em ambiente de produção é necessário definir as seguintes variáveis de ambiente:

* SECRET_TOKEN (do Ruby on Rails)
* ADMIN_PASSWORD (password de acesso à zona de administração, o username é "admin")
* MONGODB_HOST (servidor de base de dados MongoDB)
* MONGODB_DATABASE (nome da base de dados MongoDB)
* MONGODB_USERNAME (utilizador da base de dados MongoDB)
* MONGODB_PASSWORD (password do utilizador da base de dados MongoDB)
* NEW_RELIC_LICENSE_KEY (licença de utilização do New Relic para a monitorização da aplicação)
