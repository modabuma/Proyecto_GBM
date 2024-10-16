-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-10-2024 a las 17:29:35
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `observability_center`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `observability`
--

CREATE TABLE `observability` (
  `id` int(11) NOT NULL,
  `name_rest` varchar(100) NOT NULL,
  `last_name_rest` varchar(100) NOT NULL,
  `name_not_rest` varchar(100) NOT NULL,
  `last_name_not_rest` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `role` tinyint(4) DEFAULT 3,
  `admin` int(11) NOT NULL,
  `active` tinyint(4) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `last_name`, `role`, `admin`, `active`, `created_at`, `updated_at`) VALUES
(3, 'mbueno@gbm.net', '$2b$12$tsE4aR4azb8WC4HiuicID.XcfqqJTxAdn1qFYNeFh0mED/5E7JLIy', 'Moises Daniel', 'Bueno Macias', 1, 1, 1, '2024-08-29 01:10:22', '2024-10-15 18:11:37'),
(8, 'scambronero@gbm.net', '$2b$12$kyMcaT.rRGPDfTKdcPS9sOL9ZCwPRImEx6GEkfyC9Cyl/QtBsFYy.', 'Steven David', 'Cambronero', 2, 0, 1, '2024-08-29 01:58:18', '2024-09-17 23:55:14'),
(9, 'adchavez@gbm.net', '$2b$12$UoBWPnlbhK5r4io7N9fcHevbzzeybXzCcBxZv0uGyJ8USUyJP86oy', 'Adiac', 'Chavez', 2, 0, 1, '2024-08-29 01:58:53', '2024-09-17 23:40:13'),
(10, 'alguerra@gbm.net', '$2b$12$kM/cre9Z0Bfdt.CWBpILIOzhps4DgfyDlvLICITpQ4JPyh/NaCU4K', 'Alissa', 'Guerra', 2, 0, 1, '2024-08-29 01:59:26', '2024-09-17 23:40:20'),
(11, 'cobregon@gbm.net', '$2b$12$LwghUE9wCRnoJbfv09osg.fuyD68PupUWFOrnQFNCL/1f8yAuj88m', 'Cristhofer', 'Obregon Ibarra', 2, 0, 1, '2024-08-29 02:00:21', '2024-09-17 23:40:27'),
(12, 'jefjimenez@gbm.net', '$2b$12$VIAX4JqARZ22KH.yA0NuAO5hXq/Dv0TPF2Cgo99HHDfRflXD0vatm', 'Jeffry', 'Jimenez', 2, 0, 1, '2024-08-29 02:01:05', '2024-09-17 23:40:33'),
(13, 'hegarro@gbm.net', '$2b$12$AhfcxeewDhp37JVc442ROOnO5dBJfUJ8ohSIeIN8xmL9JgucwE.fK', 'Heily', 'Garro', 2, 0, 1, '2024-08-29 02:01:37', '2024-09-17 23:40:40'),
(14, 'jfilot@gbm.net', '$2b$12$BZZKjYyJAofWd7BXaLYR.ekM/8FvsHfxeNbw1BOi5TWQc8n2Cpn2y', 'Johann Enrique', 'Filot', 3, 0, 1, '2024-08-29 02:25:14', '2024-08-29 02:25:14'),
(15, 'mapolanco@gbm.net', '$2b$12$LQg3NzM3o91eo4kKbWgAmOdtUsxCahP5qXR5wbdFD7tsjjkQ0Mj0G', 'Manuel Alfredo', 'Polanco', 3, 0, 1, '2024-08-29 02:25:58', '2024-08-29 02:25:58'),
(16, 'bcastro@gbm.net', '$2b$12$aCkT7AkOUI0aJV0D9cxOi.qWId7Q7PxDP2ix0UB7JyApN1XJc4JCG', 'Boris', 'Castro Jimenez', 3, 0, 1, '2024-08-29 02:26:26', '2024-08-29 02:26:26'),
(17, 'jhruiz@gbm.net', '$2b$12$FBN5FD9bwSiJ6fkisnzaYuCVyZ7Wabbv9vcXEMQHJI1sxXfh8B.8y', 'Jhonnier', 'Ruiz Lora', 3, 0, 1, '2024-08-29 02:27:01', '2024-08-29 02:27:01'),
(18, 'jumora@gbm.net', '$2b$12$zqhJTI21qTeBH0h39r4og.SdPzdCdYwK7iRPpNAUSKvxTtb9Y05Xy', 'Juan', 'Mora', 3, 0, 1, '2024-08-29 02:27:25', '2024-08-29 02:27:25'),
(19, 'jcamargo@gbm.net', '$2b$12$YbrIbDL2U2pVyd1bGFXLve7NK2D1aDXBFECWsQRkF3tsDjy26Kfpe', 'Jorge Luis', 'Camargo', 3, 0, 1, '2024-08-29 02:28:07', '2024-08-29 02:28:07'),
(20, 'almorales@gbm.net', '$2b$12$NO9X9MBApgWhkJX70uQKF.9ms4GuFwysxniQt8/M.8dj9VNWzdo/6', 'Aldo Mario', 'Morales', 3, 0, 1, '2024-08-29 02:28:30', '2024-08-29 02:28:30'),
(21, 'sahernandez@gbm.net', '$2b$12$ueoYSBXujuHmQXnx/sAioOyx4.SzO3POKcyhvEGlmRFsOYKM/kBq6', 'Sebastian Andres', 'Hernandez', 3, 0, 1, '2024-08-29 02:29:25', '2024-08-29 02:29:25'),
(22, 'claborde@gbm.net', '$2b$12$E8ZRJLgYdvvUDHUw/SGyn.r8F.mLf9t.haG1yjo2SUPyGfGAy75RO', 'Camilo Rafael', 'Laborde', 3, 0, 1, '2024-08-29 02:29:55', '2024-08-29 02:29:55'),
(23, 'kaquintero@gbm.net', '$2b$12$ie825/k1c9u1crdXZinj7u8N.4Zq6C0MCKcF8H/1Csy8KCfK.xcyG', 'Katherine', 'Quintero', 3, 0, 1, '2024-08-29 02:30:44', '2024-08-29 02:30:44'),
(24, 'prueba@gbm.net', '$2b$12$E0zG5DuvdSHeNYk.iZJjZutr2OYxensvsfixy0fujMcHypNzp.ooO', 'prueba 1', 'prueba 2', 2, 0, 1, '2024-09-17 23:51:22', '2024-09-17 23:51:22'),
(26, 'prueba3@gbm.net', '$2b$12$FbnXzUfKjs0W6Lu.YS9ivepdbkOG3QklN8bcysommyKDKGGrKoc7O', 'prueba111', 'prueba1211', 3, 0, 1, '2024-09-17 23:53:59', '2024-09-17 23:53:59');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `observability`
--
ALTER TABLE `observability`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `observability`
--
ALTER TABLE `observability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
