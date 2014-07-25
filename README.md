# rnfse
[![Gem Version](http://img.shields.io/gem/v/rnfse.svg?style=flat)](http://rubygems.org/gems/rnfse)
[![Dependency Status](https://img.shields.io/gemnasium/aitherios/rnfse.svg?style=flat)](https://gemnasium.com/aitherios/rnfse)
[![Build Status](https://img.shields.io/travis/aitherios/rnfse.svg?style=flat)](https://travis-ci.org/aitherios/rnfse)
[![Coverage](https://img.shields.io/codeclimate/coverage/github/aitherios/rnfse.svg?style=flat)](https://codeclimate.com/github/aitherios/rnfse)

Biblioteca para integração com as várias implementações
municipais de Nota Fiscal de Serviços eletrônica (NFS-e) que utilizam uma 
das versões ou variações dos padrões
[ABRASF](http://www.abrasf.org.br/paginas_multiplas_detalhes.php?cod_pagina=1).

> O grande problema do nosso sistema democrático é que permite fazer coisas nada democráticas democraticamente.
> [José Saramago](http://pt.wikipedia.org/wiki/Jos%C3%A9_Saramago)

## Instalação

Usando o rubygems.org rode:
```shell
$ gem install rnfse
```
**Ou** usando o repositório git rode:
```shell
$ gem build rnfse.gemspec
$ gem install rnfse-X.X.X.gem
```
**Ou** usando o bundler, adicione o Rnfse ao seu Gemfile:

```ruby
gem 'rnfse'
```

E rode `$ bundle install`

## Uso

## Limitações e problemas conhecidos

Esta é uma lista de limitações e problemas conhecidos. São questões que não tem 
plano imediato de resolução. Talvez porque a funcionalidade nunca foi 
necessária ou nenhum pull request tenha sido enviado. (dica!)

- Sem documentação =/
- Suporte para o JRuby e Rubinius (problema com a dependência nokogiri-xmlsec1).
- Só foi testada com municípios inscritos no [ISS.net](http://www.issnetonline.com.br/portaliss/) que utilizam o padrão [ABRASF v1](http://www.abrasf.org.br/paginas_multiplas_detalhes.php?cod_pagina=1).

## Contribuindo

Antes do tudo, **obrigado** por querer ajudar!

1. [Faça um fork do projeto](https://help.github.com/articles/fork-a-repo).
2. Crie um branch para a funcionalidade - `git checkout -b mais_magia`
3. Adicione testes e faça suas mudanças!
4. Confira se os testes passam - `bundle exec rake`
5. Faça um commit das suas mudanças - `git commit -am "Adicionei mais magia"`
6. Faça um push do branch para o Github - `git push origin mais_magia`
7. Envie um [pull request](https://help.github.com/articles/using-pull-requests)! :heart: :sparkling_heart: :heart:

## Licença

Duplamente licenciado por GPL-3 e MIT. Veja [LICENSE.md](LICENSE.md) para mais detalhes.
