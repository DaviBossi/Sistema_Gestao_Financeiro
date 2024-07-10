-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: teste
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Principal identificador do cliente',
  `Nome` varchar(50) NOT NULL COMMENT 'Nome do cliente',
  `CPF` bigint NOT NULL COMMENT 'CPF do cliente ',
  `Telefone` varchar(50) NOT NULL COMMENT 'Telefone do cliente',
  `Email` varchar(50) NOT NULL COMMENT 'Email do cliente',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pessoa que podera criar uma conta na empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Davi Bossi',14024814621,'35998829524','davi.pereira2205@gmail.com'),(2,'Sofia Francalino',14024814654,'35998829523','sofia.francalino2205@gmail.com'),(3,'Alice Silva',12345678901,'11987654321','alice.silva@example.com'),(4,'Bruno Souza',23456789012,'11976543210','bruno.souza@example.com'),(5,'Carla Oliveira',34567890123,'11965432109','carla.oliveira@example.com'),(6,'Daniel Ferreira',45678901234,'11954321098','daniel.ferreira@example.com'),(7,'Eduarda Lima',56789012345,'11943210987','eduarda.lima@example.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta_bancaria`
--

DROP TABLE IF EXISTS `conta_bancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta_bancaria` (
  `Numero_Conta` int NOT NULL COMMENT 'Principal identificador de uma conta.',
  `Saldo` decimal(12,2) DEFAULT '0.00',
  `Credito` decimal(12,2) DEFAULT NULL COMMENT 'Quantidade gasta em crédito na conta.',
  `Tipo_Conta` varchar(50) NOT NULL COMMENT 'Tipo da conta do cliente, podendo ser uma conta pessoal ou empresarial.',
  `Cliente_ID` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico do cliente, tambem é o que relaciona um cliente a uma conta.',
  PRIMARY KEY (`Numero_Conta`),
  UNIQUE KEY `Cliente_ID` (`Cliente_ID`),
  CONSTRAINT `Conta_bancaria_Cliente` FOREIGN KEY (`Cliente_ID`) REFERENCES `cliente` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Conta onde será controlado o saldo do cliente, assim como todas as operações feitas por ele.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta_bancaria`
--

LOCK TABLES `conta_bancaria` WRITE;
/*!40000 ALTER TABLE `conta_bancaria` DISABLE KEYS */;
INSERT INTO `conta_bancaria` VALUES (1,5000.00,0.00,'Pessoa fisica',1),(2,2500.00,250.00,'Pessoa fisica',2),(3,3840.00,0.00,'Pessoal',3),(4,6589.00,250.00,'Pessoal',4),(5,14521.00,350.00,'Empresarial',5),(6,1200.00,500.00,'Pessoal',6),(7,12000.00,0.00,'Empresarial',7);
/*!40000 ALTER TABLE `conta_bancaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `Cliente_ID` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Principal característica que identifica os endereços, tambem é a chave que relaciona ao cliente.',
  `Rua` varchar(50) NOT NULL COMMENT 'Rua em que o cliente mora',
  `Bairro` varchar(50) NOT NULL COMMENT 'Bairro em que o cliente mora',
  `Cidade` varchar(50) NOT NULL COMMENT 'Cidade em que o cliente mora',
  `Pais` varchar(50) NOT NULL COMMENT 'Pais em que o cliente mora',
  PRIMARY KEY (`Cliente_ID`),
  UNIQUE KEY `Cliente_ID` (`Cliente_ID`),
  CONSTRAINT `Endereco_Cliente` FOREIGN KEY (`Cliente_ID`) REFERENCES `cliente` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Local onde o cliente mora.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extrato`
--

DROP TABLE IF EXISTS `extrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extrato` (
  `Valor da Compra` decimal(10,2) NOT NULL,
  `ID` int NOT NULL AUTO_INCREMENT,
  `Data` datetime NOT NULL,
  `Conta_Participante` int NOT NULL,
  `Descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `extrato_conta_bancaria_FK` (`Conta_Participante`),
  CONSTRAINT `extrato_conta_bancaria_FK` FOREIGN KEY (`Conta_Participante`) REFERENCES `conta_bancaria` (`Numero_Conta`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extrato`
--

LOCK TABLES `extrato` WRITE;
/*!40000 ALTER TABLE `extrato` DISABLE KEYS */;
/*!40000 ALTER TABLE `extrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fatura`
--

DROP TABLE IF EXISTS `fatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fatura` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador Unico de uma fatura.',
  `Data_Pagamento` datetime NOT NULL COMMENT 'Data em que essa fatura foi emitida.',
  `Valor_Total` decimal(12,2) NOT NULL COMMENT 'Valor da fatura.',
  `Numero_Conta` int NOT NULL COMMENT 'Numero da conta a qual a fatura pertence. Tambem é a chave que liga essa tabela a tabela de conta.',
  PRIMARY KEY (`ID`),
  KEY `Fatura_Conta_bancaria` (`Numero_Conta`),
  CONSTRAINT `Fatura_Conta_bancaria` FOREIGN KEY (`Numero_Conta`) REFERENCES `conta_bancaria` (`Numero_Conta`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Quantidade de dinheiro gasta por um cliente no crédito.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fatura`
--

LOCK TABLES `fatura` WRITE;
/*!40000 ALTER TABLE `fatura` DISABLE KEYS */;
/*!40000 ALTER TABLE `fatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investimento`
--

DROP TABLE IF EXISTS `investimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investimento` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico do investimento.',
  `Tipo_Investimento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Tipo do investimento realizado.',
  `Valor_Inicial` decimal(12,2) NOT NULL COMMENT 'Valor que o cliente disponibilizou para um investimento.',
  `Valor_Final` decimal(12,2) DEFAULT NULL COMMENT 'Valor a ser coletado pelo cliente no final do investimento.',
  `Data_Inicio` datetime NOT NULL COMMENT 'Data que o investimento ira iniciar.',
  `Data_Final` datetime DEFAULT NULL COMMENT 'Data em que o cliente recolhera o dinheiro investido.',
  `Conta_Participante` int NOT NULL COMMENT 'Conta em que esse investimento foi feito. Tambem é a chave que liga essa tabela a tabela de conta.',
  PRIMARY KEY (`ID`),
  KEY `Investismento_Conta_bancaria` (`Conta_Participante`),
  CONSTRAINT `Investismento_Conta_bancaria` FOREIGN KEY (`Conta_Participante`) REFERENCES `conta_bancaria` (`Numero_Conta`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Investimento realizado por uma conta bancaria.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investimento`
--

LOCK TABLES `investimento` WRITE;
/*!40000 ALTER TABLE `investimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `investimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planejamento_orcamentario`
--

DROP TABLE IF EXISTS `planejamento_orcamentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planejamento_orcamentario` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico do planejamento orçamentário.',
  `Valor_Limite` decimal(12,2) NOT NULL COMMENT 'Quantidade de dinheiro que o cliente estipulou que é o seu teto de gastos.',
  `Duracao` datetime NOT NULL COMMENT 'Quantidade de tempo em que esse planejamento estará vigente.',
  `Descricao` varchar(50) DEFAULT NULL COMMENT 'Descrição do planejamento, podendo ser nulo',
  `Numero_Conta` int NOT NULL COMMENT 'Conta em que o planejamento ocorreu. Tambem é a chave que liga essa tabela a tabela de conta.',
  PRIMARY KEY (`ID`),
  KEY `Planejamento_Orcamentario_Conta_bancaria` (`Numero_Conta`),
  CONSTRAINT `Planejamento_Orcamentario_Conta_bancaria` FOREIGN KEY (`Numero_Conta`) REFERENCES `conta_bancaria` (`Numero_Conta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Ferramenta para controle de gastos do cliente.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planejamento_orcamentario`
--

LOCK TABLES `planejamento_orcamentario` WRITE;
/*!40000 ALTER TABLE `planejamento_orcamentario` DISABLE KEYS */;
/*!40000 ALTER TABLE `planejamento_orcamentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacao`
--

DROP TABLE IF EXISTS `transacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacao` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador principal da transação.',
  `Data` datetime NOT NULL COMMENT 'Data em que a transação ocorreu.',
  `Valor` decimal(12,2) NOT NULL COMMENT 'Valor da transação.',
  `Tipo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Tipo da transação, podendo ser compra de alguma coisa ou recebimento de dinheiro de algum banco externo.',
  `Conta_Participante` int NOT NULL COMMENT 'Conta em que essa transação aconteceu. Tambem é a chave que liga essa tabela a tabela de conta.',
  PRIMARY KEY (`ID`),
  KEY `Transacao_Conta_bancaria` (`Conta_Participante`),
  CONSTRAINT `Transacao_Conta_bancaria` FOREIGN KEY (`Conta_Participante`) REFERENCES `conta_bancaria` (`Numero_Conta`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Transação de dinheiro que não é entre duas contas desse banco.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacao`
--

LOCK TABLES `transacao` WRITE;
/*!40000 ALTER TABLE `transacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `transacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencia`
--

DROP TABLE IF EXISTS `transferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transferencia` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico da transferência.',
  `Data` datetime NOT NULL COMMENT 'Data em que a transferência ocorreu.',
  `Valor` decimal(12,2) NOT NULL COMMENT 'Valor da transferência.',
  `Conta_Origem` int NOT NULL COMMENT 'Conta da onde o dinheiro saiu. Tambem é a chave que liga essa tabela a tabela de conta.',
  `Conta_Destino` int NOT NULL COMMENT 'Conta para onde o dinheiro vai. Tambem é a chave que liga essa tabela a tabela de conta.',
  PRIMARY KEY (`ID`),
  KEY `Transferencia_Conta_Origem` (`Conta_Origem`),
  KEY `Transferencia_Conta_Destino` (`Conta_Destino`),
  CONSTRAINT `Transferencia_Conta_Destino` FOREIGN KEY (`Conta_Destino`) REFERENCES `conta_bancaria` (`Numero_Conta`),
  CONSTRAINT `Transferencia_Conta_Origem` FOREIGN KEY (`Conta_Origem`) REFERENCES `conta_bancaria` (`Numero_Conta`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Operação de envio de dinheiro entre duas contas desse banco.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencia`
--

LOCK TABLES `transferencia` WRITE;
/*!40000 ALTER TABLE `transferencia` DISABLE KEYS */;
INSERT INTO `transferencia` VALUES (11,'2024-07-04 14:00:59',50.00,2,1);
/*!40000 ALTER TABLE `transferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'teste'
--
/*!50003 DROP PROCEDURE IF EXISTS `Gasto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Gasto`(
	in p_Conta int,
	in p_Valor decimal(10,2),
	in p_Descricao varchar(100),
	in p_Tipo int
)
begin 
	declare Saldo_Conta DECIMAL(10,2);
	declare Saldo_Credito DECIMAL(10,2);
	declare Tipo_Compra VARCHAR(100);

	start transaction;

	select Saldo 
	into Saldo_Conta
	from conta_bancaria 
	where Numero_Conta = p_Conta
	for update;

	select Credito 
	into Saldo_Credito
	from conta_bancaria 
	where Numero_Conta = p_Conta
	for update;

	if p_Tipo = 1 then
	
		if p_Valor > Saldo_Conta then 
		
			rollback;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente para realizar a compra';
		
		else 
			
			update conta_bancaria 
			set Saldo = Saldo - p_Valor
			where Numero_Conta = p_Conta;
		
			set Tipo_Compra = CONCAT('[DÉBITO]', p_Descricao);
		
			insert into extrato (`Valor da Compra`,`Data`,Conta_Participante,Descricao)
			values (p_Valor,now(),p_Conta,Tipo_Compra);
		
		end if;
	
	else 
		
		if p_Valor + Saldo_Credito > 3000 then
			
			rollback;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Limite de crédito insuficiente para realizar a compra';
		
		else
		
			update conta_bancaria 
			set Credito = Credito + p_Valor
			where Numero_Conta = p_Conta;
		
			set Tipo_Compra = CONCAT('[CRÉDITO]', p_Descricao);
		
			insert into extrato (`Valor da Compra`,`Data`,Conta_Participante,Descricao)
			values (p_Valor,now(),p_Conta,Tipo_Compra);
		
		end if;
	
	end if;
	commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Investimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Investimento`(
	in p_Conta_Participante int,
	in p_Valor_Inicial decimal(10,2),
	in p_Tipo varchar(50)
	
)
begin 
	declare Saldo_Conta DECIMAL(10,2);
	declare p_Data_Final datetime;
	declare p_Valor_Final decimal(10,2);

	start transaction;

	select Saldo 
	into Saldo_Conta
	from conta_bancaria 
	where Numero_Conta = p_Conta_Participante
	for update;

	if p_Valor_Inicial >  Saldo_Conta then 
	
		rollback;
		signal sqlstate '45000' set message_text = 'Saldo insuficiente para realizar o investimento';
	
	else 
		
		set p_Data_Final = date_add(now(), interval 1 year);
	
		set p_Valor_Final = p_Valor_Inicial * 1.15;
		
		insert into investimento (Tipo_Investimento,Valor_Inicial,Valor_Final,Data_Inicio,Data_Final,Conta_Participante)
		values (p_Tipo,p_Valor_Inicial,p_Valor_Final,now(),p_Data_Final,p_Conta_Participante);
	
		update conta_bancaria 
		set Saldo = Saldo - p_Valor_Inicial
		where Numero_Conta = p_Conta_Participante;
	
	end if;
	commit;
		
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Pagar_Fatura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Pagar_Fatura`(
	in p_Valor DECIMAL(10,2),
	in p_Conta INT
)
begin 
	declare Saldo_Credito DECIMAL(10,2);

	start transaction;

	select Credito 
	into Saldo_Credito
	from conta_bancaria 
	where Numero_Conta = p_Conta
	for update;

	if Saldo_Credito < p_Valor then
	
		rollback;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O valor a ser pago supera o valor da fatura';
	
	else
		
		insert into fatura (Data_Pagamento,Valor_Total,Numero_Conta)
		values (now(),p_Valor,p_Conta);
	
		update conta_bancaria 
		set Credito = Credito - p_Valor
		where Numero_Conta = p_Conta;
	
	end if;

	commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Planejamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Planejamento`(
	in p_Valor DECIMAL(10,2),
	in P_Descricao VARCHAR(50),
	in p_Conta INT,
	in p_Duracao INT
)
begin
	declare Saldo_Conta DECIMAL(10,2);
	declare Duracao_Plan DATETIME;

	start transaction;

	select Saldo 
	into Saldo_Conta
	from conta_bancaria 
	where Numero_Conta = p_Conta
	for update;
	
	update conta_bancaria
	set Saldo = Saldo - p_Valor
	where Numero_Conta = p_Conta;

	set Duracao_Plan = date_add(now(), interval p_Duracao month);
	
	insert into planejamento_orcamentario (Valor_Limite,Duracao,Descricao,Numero_Conta)
	values (p_Valor,Duracao_Plan,p_Descricao,p_Conta);

	commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Transacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transacao`(
	in p_Conta_Participante INT,
	in p_Valor decimal(10,2)
)
begin 
	
	declare Saldo_Conta DECIMAL(10,2);
	declare Tipo_Transferencia VARCHAR(50);
	
	start transaction;

	select Saldo 
	into Saldo_Conta
	from conta_bancaria 
	where Numero_Conta = p_Conta_Participante
	for update;

	if p_Valor > 0 then
	
		set Tipo_Transferencia = '- [DEPOSITO]';
	
		insert into transacao (`Data`,Valor,Tipo,Conta_Participante)
		values (now(),p_Valor,Tipo_Transferencia,p_Conta_Participante);
	
		update conta_bancaria 
		set Saldo = Saldo + p_Valor
		where Numero_Conta = p_Conta_Participante;
		
	else 
		
		if Saldo_Conta < p_Valor * -1 then 
		
			rollback;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente para realizar o saque';
		
		else
			
			set Tipo_Transferencia = '- [SAQUE]';
		
			insert into transacao (`Data`,Valor,Tipo,Conta_Participante)
			values (now(),p_Valor,Tipo_Transferencia,p_Conta_Participante);
		
			update conta_bancaria 
			set Saldo = Saldo + p_Valor
			where Numero_Conta = p_Conta_Participante;
		
		end if;
	
	end if;	
	commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Transferencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transferencia`(
	in p_Conta_Origem INT,
	in p_Conta_Destino INT,
	in p_Valor DECIMAL (10,2)
)
begin 
	declare Saldo_Conta DECIMAL(10,2);

	start transaction;

	select Saldo 
	into Saldo_Conta
	from conta_bancaria 
	where Numero_Conta = p_Conta_Origem
	for update;

	if Saldo_Conta < p_Valor then 
	
		rollback;
		signal sqlstate '45000' set message_text = 'Saldo insuficiente para realizar a transferência';
	
	else 
	
		insert into transferencia (`Data`,Valor,Conta_Origem,Conta_Destino)
		values (now(),p_Valor,p_Conta_Origem,p_Conta_Destino);
	
		update conta_bancaria 
		set Saldo = Saldo - p_Valor
		where Numero_Conta = p_Conta_Origem;
	
		update conta_bancaria 
		set Saldo = Saldo + p_Valor
		where Numero_Conta = p_Conta_Destino;
	
	end if;
	commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-04 17:22:24
