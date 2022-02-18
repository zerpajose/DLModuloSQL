CREATE DATABASE blog
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

CREATE TABLE usuario(
	id SERIAL,
	email VARCHAR(255),
	PRIMARY KEY (id)
);

CREATE TABLE post(
	id SERIAL,
	usuario_id INT,
	titulo VARCHAR(255),
	fecha DATE,
	PRIMARY KEY (id),
	FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE comentario(
	id SERIAL,
	usuario_id INT,
	post_id INT,
	texto VARCHAR(255),
	fecha DATE,
	PRIMARY KEY (id),
	FOREIGN KEY (usuario_id) REFERENCES usuario(id),
	FOREIGN KEY (post_id) REFERENCES post(id)
);

SELECT usuario.email, post.id, post.titulo
FROM post
JOIN usuario ON usuario.id=post.usuario_id
WHERE usuario.id = 5;

SELECT usuario.email, comentario.id, comentario.texto
FROM comentario
INNER JOIN usuario
ON comentario.usuario_id = usuario.id
AND NOT email = 'usuario06@hotmail.com';

SELECT usuario.email
FROM usuario
LEFT JOIN post ON usuario.id = post.usuario_id
WHERE post.usuario_id IS NULL;

SELECT *
FROM post
FULL OUTER JOIN comentario ON post.id = comentario.post_id;

SELECT * FROM usuario
JOIN post ON usuario.id = post.usuario_id
WHERE EXTRACT(MONTH FROM post.fecha) = '6';
