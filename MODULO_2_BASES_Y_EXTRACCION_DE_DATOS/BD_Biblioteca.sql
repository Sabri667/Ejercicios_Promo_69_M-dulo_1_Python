-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`TB_Libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TB_Libros` (
  `idTB_Libros` INT NOT NULL,
  `titulo_libro` VARCHAR(45) NULL,
  `año_pub_libro` DATETIME NULL,
  `categoria_libro` VARCHAR(45) NULL,
  PRIMARY KEY (`idTB_Libros`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TB_Autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TB_Autores` (
  `idTB_Autores` INT NOT NULL,
  `nombre_autores` VARCHAR(45) NULL,
  `apellido_autores` VARCHAR(45) NULL,
  PRIMARY KEY (`idTB_Autores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TB_Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TB_Usuarios` (
  `idTB_Usuarios` INT NOT NULL,
  `nombre_usuario` VARCHAR(45) NULL,
  `apellido_usuario` VARCHAR(45) NULL,
  `fecha_registro` DATETIME NULL,
  PRIMARY KEY (`idTB_Usuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TB_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TB_Pedidos` (
  `idTB_Pedidos` INT NOT NULL,
  `fecha_retiro` DATETIME NULL,
  `fecha_devolucion` DATETIME NULL,
  `TB_Usuarios_idTB_Usuarios` INT NOT NULL,
  PRIMARY KEY (`TB_Usuarios_idTB_Usuarios`, `idTB_Pedidos`),
  INDEX `fk_TB_Pedidos_TB_Usuarios1_idx` (`TB_Usuarios_idTB_Usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_TB_Pedidos_TB_Usuarios1`
    FOREIGN KEY (`TB_Usuarios_idTB_Usuarios`)
    REFERENCES `mydb`.`TB_Usuarios` (`idTB_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TB_Autores_has_TB_Libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TB_Autores_has_TB_Libros` (
  `TB_Autores_idTB_Autores` INT NOT NULL,
  `TB_Libros_idTB_Libros` INT NOT NULL,
  PRIMARY KEY (`TB_Autores_idTB_Autores`, `TB_Libros_idTB_Libros`),
  INDEX `fk_TB_Autores_has_TB_Libros_TB_Libros1_idx` (`TB_Libros_idTB_Libros` ASC) VISIBLE,
  INDEX `fk_TB_Autores_has_TB_Libros_TB_Autores1_idx` (`TB_Autores_idTB_Autores` ASC) VISIBLE,
  CONSTRAINT `fk_TB_Autores_has_TB_Libros_TB_Autores1`
    FOREIGN KEY (`TB_Autores_idTB_Autores`)
    REFERENCES `mydb`.`TB_Autores` (`idTB_Autores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_Autores_has_TB_Libros_TB_Libros1`
    FOREIGN KEY (`TB_Libros_idTB_Libros`)
    REFERENCES `mydb`.`TB_Libros` (`idTB_Libros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TB_Libros_has_TB_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TB_Libros_has_TB_Pedidos` (
  `TB_Libros_idTB_Libros` INT NOT NULL,
  `TB_Pedidos_TB_Usuarios_idTB_Usuarios` INT NOT NULL,
  `TB_Pedidos_idTB_Pedidos` INT NOT NULL,
  PRIMARY KEY (`TB_Libros_idTB_Libros`, `TB_Pedidos_TB_Usuarios_idTB_Usuarios`, `TB_Pedidos_idTB_Pedidos`),
  INDEX `fk_TB_Libros_has_TB_Pedidos_TB_Pedidos1_idx` (`TB_Pedidos_TB_Usuarios_idTB_Usuarios` ASC, `TB_Pedidos_idTB_Pedidos` ASC) VISIBLE,
  INDEX `fk_TB_Libros_has_TB_Pedidos_TB_Libros1_idx` (`TB_Libros_idTB_Libros` ASC) VISIBLE,
  CONSTRAINT `fk_TB_Libros_has_TB_Pedidos_TB_Libros1`
    FOREIGN KEY (`TB_Libros_idTB_Libros`)
    REFERENCES `mydb`.`TB_Libros` (`idTB_Libros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_Libros_has_TB_Pedidos_TB_Pedidos1`
    FOREIGN KEY (`TB_Pedidos_TB_Usuarios_idTB_Usuarios` , `TB_Pedidos_idTB_Pedidos`)
    REFERENCES `mydb`.`TB_Pedidos` (`TB_Usuarios_idTB_Usuarios` , `idTB_Pedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
idTB_AutoresTB_Autores