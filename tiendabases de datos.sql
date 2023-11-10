-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-11-2023 a las 22:15:59
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbclientes`
--

CREATE TABLE `tbclientes` (
  `idcliente` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(30) DEFAULT NULL,
  `direccion` varchar(60) DEFAULT NULL,
  `telefono` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbclientes`
--

INSERT INTO `tbclientes` (`idcliente`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES
(1, 'JUAN', 'PEREZ', 'CARCHA', '20368974'),
(2, 'MARIA', 'MARTINEZ', 'COBAN', '01237458'),
(3, 'CARLOS', 'JUAREZ', 'CHAMELCO', '25896347');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbdetallepedido`
--

CREATE TABLE `tbdetallepedido` (
  `iddetalle` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `idpedido` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbdetallepedido`
--

INSERT INTO `tbdetallepedido` (`iddetalle`, `cantidad`, `idpedido`, `idproducto`) VALUES
(1, 5, 1, 2),
(2, 10, 2, 3),
(3, 20, 3, 1);

--
-- Disparadores `tbdetallepedido`
--
DELIMITER $$
CREATE TRIGGER `actualizarStock` AFTER INSERT ON `tbdetallepedido` FOR EACH ROW begin
update tbproductos
set stock = stock - new.cantidad
where idproducto  = new.idproducto;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbpedido`
--

CREATE TABLE `tbpedido` (
  `fechaPedido` date DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `idpedido` int(11) NOT NULL,
  `idcliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbpedido`
--

INSERT INTO `tbpedido` (`fechaPedido`, `descripcion`, `idpedido`, `idcliente`) VALUES
('2023-11-12', 'entregado', 1, 2),
('2023-11-11', 'encamino', 2, 1),
('2023-11-12', 'entregado', 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbproductos`
--

CREATE TABLE `tbproductos` (
  `idproducto` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbproductos`
--

INSERT INTO `tbproductos` (`idproducto`, `nombre`, `precio`, `stock`) VALUES
(1, 'zapatos', 50, 100),
(2, 'tasas', 20, 150),
(3, 'mesas', 45, 50);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbclientes`
--
ALTER TABLE `tbclientes`
  ADD PRIMARY KEY (`idcliente`);

--
-- Indices de la tabla `tbdetallepedido`
--
ALTER TABLE `tbdetallepedido`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idpedido` (`idpedido`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indices de la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  ADD PRIMARY KEY (`idpedido`),
  ADD KEY `idcliente` (`idcliente`);

--
-- Indices de la tabla `tbproductos`
--
ALTER TABLE `tbproductos`
  ADD PRIMARY KEY (`idproducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbclientes`
--
ALTER TABLE `tbclientes`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbdetallepedido`
--
ALTER TABLE `tbdetallepedido`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  MODIFY `idpedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbproductos`
--
ALTER TABLE `tbproductos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbdetallepedido`
--
ALTER TABLE `tbdetallepedido`
  ADD CONSTRAINT `tbdetallepedido_ibfk_1` FOREIGN KEY (`idpedido`) REFERENCES `tbpedido` (`idpedido`),
  ADD CONSTRAINT `tbdetallepedido_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `tbproductos` (`idproducto`);

--
-- Filtros para la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  ADD CONSTRAINT `tbpedido_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `tbclientes` (`idcliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
