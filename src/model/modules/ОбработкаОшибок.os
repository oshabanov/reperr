Процедура ОбработатьОтчетОбОшибке(ФайлЗапроса) Экспорт

	Попытка
		ИдОтчетаОбОшибке = ОтчетыОбОшибках.СохранитьОтчет(ФайлЗапроса);
	Исключение
		ВызватьИсключение("Не удалось сохранить отчет
			|" + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Попытка
		ХранилищеДанных = МенеджерНастроек.ХранилищеДанных();
		ДанныеОтчетаОбОшибке = ХранилищеДанных.ПолучитьДанныеОтчетаОбОшибке(ИдОтчетаОбОшибке);
	Исключение
		ВызватьИсключение("Ошибка извлечения данных отчета об ошибке
		|" + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Попытка
		ЗарегистрироватьОшибку(ДанныеОтчетаОбОшибке);
	Исключение
		ВызватьИсключение("Не удалось зарегистрировать ошибку
			|" + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
КонецПроцедуры

Процедура ЗарегистрироватьОшибку(ДанныеОтчетаОбОшибке)

	ПровайдерИнтеграции = МенеджерНастроек.ПровайдерИнтеграции();

	Если ПровайдерИнтеграции <> Неопределено Тогда
		ПровайдерИнтеграции.ЗарегистрироватьОшибку(ДанныеОтчетаОбОшибке);
	Иначе
		ВызватьИсключение("Регистрация ошибок в баг-трекере не настроена");
	КонецЕсли;

КонецПроцедуры

Функция СформироватьОписаниеОшибки(ДанныеОтчетаОбОшибке) Экспорт
	
	Результат = "Ошибка зарегистрирована автоматически с помощью механизмов платформы 1С 8.3.17+";
	Результат = Результат + Символы.ПС + Символы.ПС + "======================" + Символы.ПС;
	
	Инфо = ДанныеОтчетаОбОшибке.Информация;
	
	Для Каждого ЭлементИнфо Из Инфо Цикл
		
		Результат = Результат + Символы.ПС + " " + ЭлементИнфо.Ключ + ": " + Инфо[ЭлементИнфо.Ключ];
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции
