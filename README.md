# Rural de Bolso

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

-----
**Aplicativo desenvolvido para o trabalho de conclusão de curso da Universidade Federal Rural do Rio de Janeiro.**

----
#### Informações do TCC
**Título:** Aplicativo Android para Acesso ao Sistema Acadêmico da UFRRJ.
**Aluno:** Thiago Flosino
**Orientador:** Marcel William Rocha da Silva,D.Sc. DCC-UFRRJ
#### Motivação
Atualmente a UFRRJ utiliza como sistema de controle do ambiente universitário o SIGAA (Sistema Integrado de Gestão de Atividades Acadêmicas).  Esse sistema em sua versão *Web* tem as informações muitas vezes, de difícil acesso. E a versão *mobile*, além do difícil acesso, contém menos informações, sendo assim, uma versão simplificada do site original, além disso, não há um aplicativo oficial de acesso ao SIGAA para a Universidade. Com isso, decidimos prototipar um aplicativo para *smartphones*, onde os alunos possam consultar as principais informações sobre sua vida acadêmica, e assim tentarmos reduzir os problemas já citados.

#### Escolha do Framework
Decidimos utilizar o [Flutter](https://flutter.dev/) para desenvolver esse aplicativo, pois dentre as possibilidades, era o que melhor se adequava para realização de *Web Scraping* dentro do App, sem a necessidade de um servidor realizando as extrações dos dados, utulizando a biblioteca [Dio](https://pub.dev/packages/dio).

#### Features

- **Informações do Aluno**
  - Nome
  - Foto
  - Instituição
  - Período atual
  - Percentual integralizado
  - Horas obrigatória
  - Horas optativas
  - Horas complementares
- **Matérias**
  - Dia e Horário
  - Carga horária
  - Semestre
  - Andamento das Aulas
  - Notícias
  - Atividades
  - Avaliações
- **Notificações**
  - Todas as alterações nas matérias cursadas pelo aluno

