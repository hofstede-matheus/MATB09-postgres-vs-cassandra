CREATE KEYSPACE matb09 
WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor' : 1};

CREATE TABLE matb09.AlunosPorFila (
  id_fila TEXT,
  nome_fila TEXT,
  nome_aluno TEXT,
  matricula_aluno TEXT,
  data_entrada_na_fila DATE,

  PRIMARY KEY (nome_fila)
);

CREATE TABLE matb09.FilaPorTelao (
  id_telao TEXT,
  nome_telao TEXT,
  nome_fila TEXT,

  PRIMARY KEY (id_telao)
);

CREATE TABLE matb09.UsuariosPorColegiado (
  id_colegiado TEXT,
  codigo_colegiado TEXT,
  nome_colegiado TEXT,
  nome_fila TEXT,
  matricula_usuario TEXT,
  email_usuario TEXT,
  senha_usuario TEXT,
  tipo_usuario TEXT,

  PRIMARY KEY (id_colegiado)
);

CREATE MATERIALIZED VIEW matb09.AlunosPorFilaPosicaoView AS
  SELECT * FROM matb09.AlunosPorFila
  ORDER BY data_entrada_na_fila DESC
  PRIMARY KEY (id_fila, matricula_aluno);

