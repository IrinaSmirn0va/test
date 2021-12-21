-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 21 2021 г., 08:51
-- Версия сервера: 10.4.22-MariaDB
-- Версия PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `phonebook`
--

-- --------------------------------------------------------

--
-- Структура таблицы `abonent`
--

CREATE TABLE `abonent` (
  `id_abonent` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `abonent`
--

INSERT INTO `abonent` (`id_abonent`, `name`) VALUES
(1, 'Петр Иванов'),
(2, 'Лебедева Дарья'),
(3, 'Апполинария'),
(4, 'Иван'),
(5, 'Ирина Игоревна Смирнова'),
(7, 'Егор Панков'),
(8, 'asd'),
(9, 'Алла Владимировна');

-- --------------------------------------------------------

--
-- Структура таблицы `number`
--

CREATE TABLE `number` (
  `id_number` int(11) NOT NULL,
  `numberphone` bigint(20) NOT NULL,
  `type` varchar(30) DEFAULT NULL,
  `id_abonent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `number`
--

INSERT INTO `number` (`id_number`, `numberphone`, `type`, `id_abonent`) VALUES
(2, 89106663522, 'мобильный', 1),
(4, 8313639472, 'рабочий', 3),
(5, 89207538274, 'мобильный', 4),
(6, 8314754926, 'домашний', 4),
(8, 89206384628, 'мобильный', 3),
(9, 89107562844, '', 1),
(10, 89996472538, 'рабочий', 1),
(11, 4457456, 'домашний', 1),
(12, 8347437563567, 'мобильный', 1),
(13, 88314456422, 'мобильный', 5),
(14, 89206384628, 'рабочий', 7),
(15, 354323, 'домашний', 9),
(16, 78898, 'домашний', 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `abonent`
--
ALTER TABLE `abonent`
  ADD PRIMARY KEY (`id_abonent`);

--
-- Индексы таблицы `number`
--
ALTER TABLE `number`
  ADD PRIMARY KEY (`id_number`),
  ADD KEY `id_abonent` (`id_abonent`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `abonent`
--
ALTER TABLE `abonent`
  MODIFY `id_abonent` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `number`
--
ALTER TABLE `number`
  MODIFY `id_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `number`
--
ALTER TABLE `number`
  ADD CONSTRAINT `number_ibfk_1` FOREIGN KEY (`id_abonent`) REFERENCES `abonent` (`id_abonent`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
