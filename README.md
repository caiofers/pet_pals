<div align="center">
  <img src="https://github.com/caiofers/pet_pals/assets/22029338/856f57df-0ccd-4596-8425-fa6d106504b5">
</div>
<br>
<br>
<p align="center">
  <a href="#project">Projeto</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#requirements">Requisitos</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#overview">Padrão Arquitetural</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#wireframe">Wireframe</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#tecnology">Tecnologias</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#screens">Telas Implementadas</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#usage">Utilização</a>
</p>

<a name='project'></a>
## ✦ Projeto
<p align="justify">
Esse projeto é uma proposta de aplicação que atuará como facilitador da comunicação e colaboração entre os tutores dos animais de estimação (quando um animal tem vários tutores), por meio de lembretes de alimentação compartilhado entre os tutores, registro de vacinas, banhos e todos os cuidados que permeiam o bem estar animal.

Para isso, o objetivo será distribuído nas seguintes etapas:

- Levantamento de requisitos e priorização das funcionalidades mais
importantes;

- Definição de padrões para o projeto væisando o possível crescimento da
aplicação, de forma que seja fácil dar manutenção, modificar e criar novas
funcionalidades;

- Criação do protótipo de baixa fidelidade;

- Definição inicial da identidade visual de forma superficial;

- Desenvolvimento do protótipo com as funcionalidades principais para o aplicativo ser utilizável;

- Teste com usuários reais para colher feedbacks de melhoria para uma versão futura.
</p>

<a name='requirements'></a>
## ✦ Requisitos
[Requisitos Funcionais](REQUIREMENTSF.md)

[Requisitos Não-Funcionais](REQUIREMENTSNF.md)

<a name='overview'></a>
## ✦ Padrão Arquitetural

<p align="justify">
Para definir os padrões do projetos, foi levado em consideração os requisitos do sistema. Um requisito que influenciou bastante foi o RNF01, onde diz que o aplicativo deve estar disponíveis para diferentes sistemas operacionais. Com base nisso, a fim de encurtar o processo de desenvolvimento e concentrar as regras de negócio em uma única base de código, foi decidido usar o desenvolvimento híbrido, sendo mais direto, será utilizado Flutter, onde conseguimos usar uma única base de código para desenvolver para Android e iOS. 
</p>

<p align="justify">
Sobre o padrão arquitetural, o ideal é utilizar uma estrutura que deixe os módulos do aplicativo o mais independente possíveis, já que é uma aplicação média/grande com potencial para crescer ainda mais, além disso, a tecnologia escolhida possibilita muito o uso de pacotes externos, porém esses pacotes podem cair em desuso e perder o suporte, e aí entra a importância de se ter um padrão arquitetura bem desacoplado, uma vez que um pacote perca o suporte, ele deve ser facilmente substituído sem causar impacto significativo no desenvolvimento do aplicativo. 
</p>

<p align="justify">
Dito isso, o padrão arquitetural escolhido foi uma combinação de BLoC (Business Logic Components) e Clean Arquitecture. BLoC é um padrão recomendado para aplicações Flutter pois facilita o controle de estado da aplicação e, além disso, permite o reuso do mesmo código para plataformas diferentes. Já o uso da Clean Architecture tem o propósito de deixar as camadas da arquitetura bem definidas, sendo elas: camada de dados, camada de domínio e camada de apresentação.
</p>

![image](https://github.com/caiofers/pet_pals/assets/22029338/67b903d0-ac66-4262-816e-93aa9c04b7c1)

<a name='wireframe'></a>
## ✦ Protótipo Navegável

<p align="justify">
O wireframe foi construído no Figma, ele é navegável, deste modo vou deixar o link público para o protótipo. Vale ressaltar que é de fato um protótipo LoFi (Low Fidelity), então o design não tem muito a ver com o design do produto final. Nesse wireframe foi retratado a página inicial da aplicação e as funcionalidades consideradas essenciais, sendo elas: cadastro, cadastro do pet, cadastro de alertar para cuidar do pet e adição de tutores para o pet.
</p>

<a href="https://www.figma.com/file/ixfhrRCvBfbN54b2GObz0a/Protótipo-Lo-Fi---PetPals:-Pet-Manager?type=design&node-id=0:1&mode=design&t=hJRafQ4esLWOxYvV-1">Link para o protótipo navegável</a>

<a name='tecnology'></a>
## ✦ Tecnologias

<p align="justify">
O desenvolvimento de aplicações em Flutter é bastante guiado por pacote de terceiros, e podem ser consultados em pub.dev, alguns inclusive são selecionados por um comitê oficial do Flutter, sendo reconhecidos como pacotes altamente confiáveis e utilizados pela comunidade. Dito isso, vou citar alguns pacotes que ajudaram no desenvolvimento:
</p>

- provider: Pacote para auxiliar no gerenciamento de estado da aplicação e reatividade à mudanças;
- shared_preferences: Pacote para armazenar dados como preferência do usuário, utilizei para armazenar o tema selecionado no aplicativo.
- cupertino_icons: Pacote de ícones.
- flutter_localizations e intl: Pacote para deixar a aplicação localizável de acordo com o idioma do dispositivo móvel, aceitando idioma inglês e português.
- image_picker: Pacote para acessar a galeria/câmera do dispositivo móvel.
- firebase_auth: Pacote do firebase para autenticação de usuário.
- firebase_database: Pacote do firebase para armazenar dados, utilizado para armazenar informações de entidades como pets, tutores e alarmes.
- firebase_storage: Pacote do firebase para armazenar arquivos, utilizado para armazenar foto do pet.

<p align="justify">
Como pode-se observar com base nos pacotes mencionados, foi utilizado o Firebase para fazer as persistências das informações em nuvem. O banco de dados selecionado no Firebase foi o Realtime Database com base nas seguintes considerações: 
</p>

<img width="415" alt="image" src="https://github.com/caiofers/pet_pals/assets/22029338/46874be9-6437-4bf1-990e-82babdf395c4">

<a name='screens'></a>
## ✦ Telas Implementadas
<p align="justify">
          As imagens abaixo mostram as telas implementadas no app.
</p>

IMAGENS PENDENTES
<!--
<p align="middle">    
 <img alt="Splash View" title="App" src="https://github.com/pedrohso7/HP_Guide/assets/32853995/4ebcc32e-6235-4cb9-81c2-284e0e3522fe" width="300"/>
<img alt="Home View" title="App" src="https://github.com/pedrohso7/HP_Guide/assets/32853995/a5605328-4d2d-4c6f-b821-fd145c523a65" width="300"/>
<img alt="Search View" title="App" src="https://github.com/pedrohso7/HP_Guide/assets/32853995/1af90fe2-c816-46b3-9d06-dbb675d53245" width="300"/>
          <img alt="Personagens View" title="App" src="https://github.com/pedrohso7/HP_Guide/assets/32853995/b8a0444c-af09-413f-82e3-1c1358e5e015" width="300"/>
<img alt="Details 1 View" title="App" src="https://github.com/pedrohso7/HP_Guide/assets/32853995/e825c82d-5328-44ca-93b9-a19360da5ccb" width="300"/>
          <img alt="Details 2 View" title="App" src="https://github.com/pedrohso7/HP_Guide/assets/32853995/5526fe5e-f1d1-4e5f-b509-e4c86ec9fc3d" width="300"/>
</p>
-->
<a name='usage'></a>
## ✦ Utilização
<p align="justify">
          Para começar a usar o projeto, obtenha as dependências do projeto com o comando:
</p>

```
flutter pub get
```

<p align="justify">
Agora que obtemos as dependências do projeto, basta executar o projeto com o comando:
</p>

```
flutter run
```

<p align="justify">
Ao invés disso você também pode gerar um build no formato .apk e executar no seu dispositivo android utilizando:
</p>

```
flutter build apk
```
