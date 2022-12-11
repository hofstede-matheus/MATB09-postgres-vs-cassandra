CREATE KEYSPACE matb09 
WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor' : 1};

CREATE TABLE matb09.AlunosPorFila (
  id_fila TEXT,
  nome_fila TEXT,
  nome_aluno TEXT,
  matricula_aluno TEXT,
  data_entrada_na_fila TIMESTAMP,

  PRIMARY KEY (nome_fila, matricula_aluno)
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

CREATE TABLE matb09.Colegiados (
  id_colegiado TEXT,
  codigo_colegiado TEXT,
  nome_colegiado TEXT,
  PRIMARY KEY (id_colegiado)
);

CREATE MATERIALIZED VIEW matb09.AlunosSemFila AS
  SELECT * FROM matb09.AlunosPorFila
  WHERE nome_fila = NULL AND matricula_aluno IS NOT NULL
  PRIMARY KEY (matricula_aluno, nome_fila);

CREATE MATERIALIZED VIEW matb09.FilaSemAluno AS
  SELECT * FROM matb09.AlunosPorFila
  WHERE matricula_aluno = NULL AND nome_fila IS NOT NULL
  PRIMARY KEY (matricula_aluno, nome_fila);

CREATE MATERIALIZED VIEW matb09.AlunosSI AS
  SELECT * FROM matb09.AlunosPorFila
  WHERE nome_fila = 'SI' AND matricula_aluno IS NOT NULL
  PRIMARY KEY (nome_fila, matricula_aluno);

CREATE INDEX filaPorId ON matb09.AlunosPorFila (id_fila);

CREATE INDEX colegiadoPorNome ON matb09.Colegiados (nome_colegiado);

CREATE INDEX alunoPorDataDeEntrada ON matb09.AlunosPorFila (data_entrada_na_fila);

TRACING ON

BEGIN BATCH
  INSERT INTO matb09.AlunosPorFila (id_fila, nome_fila, nome_aluno, matricula_aluno, data_entrada_na_fila) VALUES ('123', 'Fila SI', 'Matheus Hofstede', '12345678', '2017-05-05 00:00:00.000+0000');
  INSERT INTO matb09.Colegiados (id_colegiado, codigo_colegiado, nome_colegiado) VALUES ('123', 'SI', 'SISTEMAS DE INFORMAÇÃO');
APPLY BATCH;

CREATE TRIGGER trigger_alunos_por_fila ON matb09.AlunosPorFila using 'com.felipead.cassandra.logger.LogTrigger';
-- CREATE TRIGGER trigger_alunos_por_fila ON matb09.AlunosPorFila using 'org.apache.cassandra.triggers.AuditTrigger';

DROP TRIGGER trigger_alunos_por_fila ON matb09.AlunosPorFila;

nodetool help snapshot
nodetool snapshot --tag matb09-snapshot matb09
find -name snapshots
nodetool listsnapshots
