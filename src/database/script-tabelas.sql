CREATE DATABASE DesbravaJa;
USE DesbravaJa;


CREATE USER 'desbravaJa'@'localhost' IDENTIFIED BY 'GodIsNotDead';
GRANT ALL PRIVILEGES ON DesbravaJa.* TO 'desbravaJa'@'localhost';
FLUSH PRIVILEGES;

CREATE TABLE tbTipoUsuario(
	idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45)
);

CREATE TABLE tbUsuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)UNIQUE,
    cpf CHAR(11)UNIQUE,
    celular CHAR(11),
    email VARCHAR(45)UNIQUE,
    senha VARCHAR(45),
    fkTipoUsuario INT,
    FOREIGN KEY (fkTipoUsuario) REFERENCES tb_tipoUsuario(idTipoUsuario)
);

-- Tabela de Relacionamento entre Desbravadores e Conselheiros
CREATE TABLE tbRelacionamento (
    idRelacionamento INT PRIMARY KEY AUTO_INCREMENT,
    idDesbravador INT,
    idConselheiro INT,
    idInstrutor INT,
    FOREIGN KEY (idDesbravador) REFERENCES tbUsuario(idUsuario),
    FOREIGN KEY (idConselheiro) REFERENCES tbUsuario(idUsuario),
    FOREIGN KEY (idInstrutor) REFERENCES tbUsuario(idUsuario)
);


CREATE TABLE tbQuestaoErrada (
    idQuestao INT PRIMARY KEY AUTO_INCREMENT,
	fkUsuario INT,
    numeroQuestao INT,
    FOREIGN KEY(fkUsuario) REFERENCES tb_usuario(idUsuario) 
);

CREATE TABLE tbMetricasQuiz (
	idMetricas INT AUTO_INCREMENT,
    fkUsuario INT,
    pontuacao INT,
    tempo TIME,
    ranking varchar(5),
    PRIMARY KEY (idMetricas,fkUsuario),
    FOREIGN KEY (fkUsuario) REFERENCES tb_usuario(idUsuario)
);

CREATE TABLE tbAvaliacao (
	idAvaliacao INT PRIMARY KEY AUTO_INCREMENT,
	fkUsuario INT UNIQUE,
	estrelas INT,
    FOREIGN KEY (fkUsuario) REFERENCES tb_usuario(idUsuario)
);

select * from Usuario;


SELECT * FROM Usuario;
 SELECT idUsuario, nome, email FROM Usuario WHERE email = 'ellen@gmail.com' AND senha = '121212';
 
 SELECT nome, pontuacao, tempo FROM MetricasQuiz JOIN Usuario ON MetricasQuiz.fkUsuario = Usuario.idUsuario 
GROUP BY nome, pontuacao, tempo ORDER BY MAX(pontuacao) DESC, MIN(tempo) ASC;


select nome, pontuacao, tempo from MetricasQuiz
	join Usuario
		on fkUsuario = idUsuario
        where (select * from MetricasQuiz GROUP BY nome);
        
	
SELECT u.nome, m.pontuacao, m.tempo FROM MetricasQuiz AS m
	JOIN Usuario AS u 
		ON m.fkUsuario = u.idUsuario
			WHERE m.pontuacao = (SELECT MAX(pontuacao) FROM MetricasQuiz WHERE fkUsuario = m.fkUsuario)
				AND m.tempo = (SELECT MIN(tempo) FROM MetricasQuiz WHERE fkUsuario = m.fkUsuario AND pontuacao = m.pontuacao)
					ORDER BY m.pontuacao DESC, m.tempo ASC;


select max(pontuacao) as Maximo, ranking FROM MetricasQuiz where fkUsuario = 1 group by pontuacao, ranking order by pontuacao desc limit 1;

