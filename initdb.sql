-- Config
create extension if not exists "uuid-ossp";


-- Tables --

  -- Colegiado
  CREATE TABLE Colegiado
  (
  codigo varchar(20) NOT NULL ,
  nome   varchar(20) NOT NULL ,

  PRIMARY KEY (codigo)
  );

  -- Aluno
  CREATE TABLE Aluno
  (
  matricula       varchar(20) NOT NULL ,
  email           varchar(20) NOT NULL ,
  idColegiado     varchar(20) NOT NULL ,
  senha           varchar(20) NOT NULL ,
  numero_telefone varchar(20) NULL ,

  PRIMARY KEY (matricula),
  FOREIGN KEY (idColegiado) REFERENCES Colegiado (codigo)
  );

  -- Coordenador
  CREATE TABLE Coordenador
  (
  matricula   varchar(20) NOT NULL ,
  email       varchar(20) NOT NULL ,
  idColegiado varchar(20) NOT NULL ,
  senha       varchar(20) NOT NULL ,

  PRIMARY KEY (matricula),
  FOREIGN KEY (idColegiado) REFERENCES Colegiado (codigo)
  );

  -- Fila
  CREATE TABLE Fila
  (
  id   int NOT NULL ,
  nome int NOT NULL ,

  PRIMARY KEY (id)
  );

  -- Telao
  CREATE TABLE Telao
  (
  id     int NOT NULL ,
  titulo int NOT NULL ,

  PRIMARY KEY (id)
  );

  -- AlunoFila
  CREATE TABLE AlunoFila
  (
  alunoMatricula varchar(20) NOT NULL ,
  filaId         int NOT NULL ,

  FOREIGN KEY (alunoMatricula) REFERENCES Aluno (matricula),
  FOREIGN KEY (filaId) REFERENCES Fila (id)
  );

  -- filaTelao
  CREATE TABLE filaTelao
  (
  filaId  int NOT NULL ,
  telaoId int NOT NULL ,

  FOREIGN KEY (filaId) REFERENCES Fila (id),
  FOREIGN KEY (telaoId) REFERENCES Telao (id)
  );

-- Seeds
