CREATE USER `wk2`@`localhost` IDENTIFIED BY 'technology';

GRANT ALL PRIVILEGES ON `wk`.* TO `wk2`@`localhost`;

CREATE TABLE `wk`.`clientes`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ix_nome`(`nome`)
);

CREATE TABLE `wk`.`produtos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `preco` DECIMAL(18,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_descricao` (`descricao`));

CREATE TABLE `wk`.`pedidos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `data_emissao` datetime NOT NULL DEFAULT current_timestamp(0),
  `valor_total` decimal(18, 2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ix_cliente_id`(`cliente_id`, `id`),
  CONSTRAINT `fk_clientes_id` FOREIGN KEY (`cliente_id`) REFERENCES `wk`.`clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `wk`.`pedidos_produtos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pedido_id` BIGINT UNSIGNED NOT NULL,
  `produto_id` BIGINT UNSIGNED NOT NULL,
  `quantidade` INT NOT NULL,
  `valor` DECIMAL(18,2) NOT NULL,
  `valor_total` DECIMAL(18,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ix_pedido_id`(`pedido_id`),
  INDEX `ix_produto_id`(`produto_id`),
  CONSTRAINT `fk_pedido_id` FOREIGN KEY (`pedido_id`) REFERENCES `wk`.`pedidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `wk`.`produtos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
	
