# Teste técnico

As instruções para uso do projeto são muitos simples. Foi escolhido o cocoapods para utilização da biblioteca **TraktKit**. Então, para configuração do projeto, faça o clone e execute:

`pod install`

# Pontos importantes

  - O layout é simples, mas foi focado em deixar as informações claras e organizadas.
  - Com o apoio do framework TrakKi, é executado o fluxo de OAuth2. O app está apontando para o ambiente de Staging do Trakt.tv.
  - Os testes unitários podem ser rodados escolhendo o **Scheme de Test**.
  - Alguns elementos simples e reutilizáveis foram desenvolvidos e encontram-se na pasta **ReusableElements**
  
# Checklist funcionalidades

  - **Uma lista das séries que ele está assistindo no momento** ✅
        
        Obs: após o login, todas as listas do usuário são retornadas e você poderá navegar nos itens dentro da mesma.
  - **A informação de quantos por cento da série já foi concluída** ✅
        
        Dando continuidade à navegação, após selecionar a série que deseja, no detalhamento algumas informações serão apresentadas:
            - Porcentagem concluída, quantidade de temporadas, ano de lançamento da séries e nome.
  - **Qual o próximo episódio (e a data)** ✅
        
        Ainda na tela de detalhamento de uma série, é verificado se possui próximo episódio, caso sim. Será apresentado o título, a data e uma pequena descrição. Caso não, as informações do último episódio são solicitadas.
  - **Uma página com as informações dos episódios (só dos próximos, só do último ou de todos fica a seu critério)** ✅
        
        Consta a informação do próximo ou do último no detalhamento de uma série.
  - **Marcar como assistido um episódio** ✅
       
       Para marcar como lido, na tela de detalhamento, selecione o botão **Temporadas e episódios** e será redirecionado para uma listagem de temporada se episódios, onde basta responder a pergunta **Já assistiu?** que você estará marcando como assistido.

# Arquitetura

Escolhi utilizar MVVM como padrão juntamente com MARK's e "extensions" para organização do código. Forma feitos alguns comentários em métodos cujo entendimento poderia ser um pouco mais complexo. 

As strings e possível tradução para outras línguas, encontra-sem no arquivo Localizable.strings. Essa abordagem visa facilitar a manutenção em caso de troca de textos e padronizar a forma de internacionalização do app, caso necessário.

Qualquer dúvida, estou à disposição:

danilord.pena@gmail.com  or
https://www.linkedin.com/in/danilo-pena-05aa7a3a/
