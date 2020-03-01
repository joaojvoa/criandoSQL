--USUARIO
CREATE TABLE Usuario (
	id INT IDENTITY PRIMARY KEY,
	logar VARCHAR(50),
	senha VARCHAR(50)
)

--COORDENADOR
CREATE TABLE Coordenador (
	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_ID_USUARIO FOREIGN KEY (id) REFERENCES Usuario(id),
	nome VARCHAR(100),
	email VARCHAR(50),
	UNIQUE(email),
	celular varchar(50),
	UNIQUE(celular)
)


--ALUNO
CREATE TABLE Aluno (
	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_USUARIO_ID FOREIGN KEY (id) REFERENCES Usuario(id),
	nome VARCHAR(100),
	email varchar(50),
	UNIQUE(email),
	ra VARCHAR(20),
	Foto TEXT
)

--PROFESSOR
CREATE TABLE Professor (
	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_ID_USUARIO FOREIGN KEY (id) REFERENCES Usuario(id),
	email VARCHAR(50),
	UNIQUE(email),
	apelido VARCHAR(50)
)

--DISCIPLINA
CREATE TABLE Disciplina (
	id INT IDENTITY PRIMARY KEY,
	nome VARCHAR(100),
	UNIQUE(nome),
	data_disciplina DATETIME,
	CONSTRAINT DF_DATA_DISCIPLINA DEFAULT (GETDATE()) FOR data_disciplina,
	status_disciplina VARCHAR(6),
	CHECK( status_disciplina IN ('ABERTA','FECHADA') ),
	planodeensino varchar(50),
	cargahoraria varchar(2),
	CHECK(cargahoraria  IN ('40','80')),
	competencias TEXT,
	habilidades TEXT,
	ementa VARCHAR(50),
	conteudoprogramatico TEXT,
	bibliografiAbasica TEXT,
	bibliografiAcomplementar TEXT,
	percentualPratico varchar(3),
	CHECK (percentualPratico in ('00','100')),
	percentualTeorico varchar(3),
	CHECK (percentualTeorico in ('00','100')),
	CONSTRAINT FK_COORDENADOR FOREIGN KEY (id) REFERENCES Coordenador(id)

)

--CURSO
CREATE TABLE Curso (
	id INT IDENTITY PRIMARY KEY,
	nome varchar(50),
	UNIQUE (nome)
)

--DISCIPLINA OFERTADA

CREATE TABLE Disciplina_Oferta (
	
	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_COORDENADOR FOREIGN KEY (id) REFERENCES Coordenador(id),
	DtInicioMatricula2 TEXT,
	DtFimMatricula2   TEXT,
	CONSTRAINT FK_DISCIPLINA FOREIGN KEY (id) REFERENCES Disciplina(id),
	CONSTRAINT FK_CURSO		 FOREIGN KEY (id)		 REFERENCES Curso(id),
	ANO INT,
	CHECK (ANO >= 1900 and ANO <= 2100),
	SEMESTRE INT
	CHECK (SEMESTRE >= 1 and SEMESTRE <= 2),
	TURMA VARCHAR (50),
	CHECK ( TURMA = '^[A-Z]{3}-\d{4}$'),
	CONSTRAINT FK_id_PROFESSOR FOREIGN KEY (id) REFERENCES Professor(id),
	METODOLOGIA			VARCHAR(100),
	RECURSOS			VARCHAR(50),
	CRITERIO_AVALIACAO	VARCHAR(50),
	PLANO_DE_AULAS		VARCHAR(100)

)

--ATIVIDADE
CREATE TABLE ATIVIDADE(
	id INT IDENTITY PRIMARY KEY,
	titulo  TEXT,
	UNIQUE (titulo),
	descricao TEXT,
	conteudo TEXT,
	TIPO TEXT,
	CHECK (TIPO  IN ('RESPOSTA ABERTA','TESTE')),
	EXTRAS TEXT,
	CONSTRAINT FK_ID_PROFESSOR FOREIGN KEY (id) REFERENCES Professor(id)
)

-- SOLICITACAOMATRICULA

CREATE TABLE SolicitacaoMatricula(	
	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_ID_ALUNO FOREIGN KEY (id) REFERENCES Aluno(id),
	CONSTRAINT FK_DISCIPLINA_OFERTADA FOREIGN KEY (id) REFERENCES Disciplina_Oferta(id),
	DtSolicitacao  DATETIME,
	CONSTRAINT DF_DATA_DtSolicitacao DEFAULT (GETDATE()) FOR DtSolicitacao,
	solicita_status varchar(10),
	CHECK (solicita_status IN ('Solicitada','Aprovada','Rejeitada','Cancelada')),
)


CREATE TABLE AtividadeVinculada (
	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_ATIVIDADE FOREIGN KEY (id) REFERENCES Atividade(id),
	CONSTRAINT FK_PROFESSOR FOREIGN KEY (id) REFERENCES Professor(id),
	CONSTRAINT FK_DISCIPLINA_OFERTA FOREIGN KEY (id) REFERENCES Disciplina_Oferta(id),
	rotulo VARCHAR(3),
	CHECK (rotulo IN ('AC1','AC2')),
	Status_atividade TEXT,
	CHECK (Status_atividade IN ('‘Disponibilizada’','‘Aberta’','‘Fechada’', '‘Encerrada’', '‘Prorrogada’')),
	DtInicioRespostas DATETIME,
	DtFimRespostas DATETIME,
)

CREATE TABLE Entrega (

	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_ID_ALUNO FOREIGN KEY (id) REFERENCES Aluno(id),
	CONSTRAINT FK_ID_ATIVIDADE_VINCULADA FOREIGN KEY (id) REFERENCES AtividadeVinculada(id),
	titulo TEXT,
	resposta TEXT,
	DtEntrega DATETIME,
	StatusEntrege TEXT,
	CHECK (StatusEntrege IN ('ENTREGUE', 'CORRIGIDO')),
	CONSTRAINT DF_StatusEntrege DEFAULT ('ENTREGUE') FOR StatusEntregue,
	CONSTRAINT FK_ID_PROFESSOR FOREIGN KEY (id) REFERENCES Professor(id),
	nota TEXT,
	CHECK (nota in ('0'-'10')),
	DtAvalicao DATETIME,
	Obs TEXT	
)

CREATE TABLE Mensagem (

	id INT IDENTITY PRIMARY KEY,
	CONSTRAINT FK_ID_ALUNO FOREIGN KEY (id) REFERENCES Aluno(id),
	CONSTRAINT FK_ID_PROFESSOR FOREIGN KEY (id) REFERENCES Professor(id),
	assunto VARCHAR(50),
	Referencia VARCHAR(50),
	Conteudo VARCHAR(50),
	Status_Mensagem TEXT,
	CHECK (Status_Mensagem IN ('ENVIADO', 'LIDO', 'RESPONDIDO')),
	DtEnvio DATETIME,
	DtResposta DATETIME,
	Resposta TEXT,

)