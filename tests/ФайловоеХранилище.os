#Использовать asserts
#Использовать tempfiles
#Использовать json
#Использовать fs
#Использовать "../src/model"

// BSLLS:UnusedParameters-off
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
// BSLLS:UnusedParameters-on
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеЗапросовИнфоОбОшибкеИзФайла");
	ВсеТесты.Добавить("ТестДолжен_ЗаписатьЗапросИнфоОбОшибкеВФайл");
	ВсеТесты.Добавить("ТестДолжен_ПолучитьОшибки");
	ВсеТесты.Добавить("ТестДолжен_ЗаписатьОшибкуВФайл");
	ВсеТесты.Добавить("ТестДолжен_СохранитьФайлОтчета");
	ВсеТесты.Добавить("ТестДолжен_УстановитьИдЗадачиВТрекере");

	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	
	УстановитьТекущийКаталог(ТекущийСценарий().Каталог);
	КаталогДанных = ОбъединитьПути("..", "features", "fixtures");
	
	ВременныйКаталог = ВременныеФайлы.СоздатьКаталог();
	ФС.КопироватьСодержимоеКаталога(КаталогДанных, ВременныйКаталог);
	УстановитьТекущийКаталог(ВременныйКаталог);
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтениеЗапросовИнфоОбОшибкеИзФайла() Экспорт

	Каталог = "data";
	ХранилищеДанных = Новый ФайловоеХранилище(Каталог);
	
	Результат = МенеджерХранилищаОшибок.Инициализировать (ХранилищеДанных, Каталог).ПолучитьЗапросыИнфоОбОшибках();
	
	Ожидаем.Что(Результат.Колонки.Количество()).Равно(14);
	Ожидаем.Что(Результат.Количество()).Равно(3);
	
КонецПроцедуры

Процедура ТестДолжен_ЗаписатьЗапросИнфоОбОшибкеВФайл() Экспорт
	
	Каталог = "data";
	ХранилищеДанных = Новый ФайловоеХранилище(Каталог);

	ЗапросИнфоОбОшибке = Новый Структура;
	ЗапросИнфоОбОшибке.Вставить("configHash", "bd56b503adfc454b9fc84d7b0fea3e7900000000");
	ЗапросИнфоОбОшибке.Вставить("сonfigName", "Config1");
	ЗапросИнфоОбОшибке.Вставить("configVersion", "1.0.1.265");
	ЗапросИнфоОбОшибке.Вставить("appStackHash", "5E78AD0E93E8D3963841DFD479A597ED");
	ЗапросИнфоОбОшибке.Вставить("clientStackHash", "84A1E9821497E377D0E1FB27C47CA523");
	ЗапросИнфоОбОшибке.Вставить("serverStackHash", "52FD5252518EE4116169922AB4251CC5");
	ЗапросИнфоОбОшибке.Вставить("platformType", "Windows_x86_64");
	ЗапросИнфоОбОшибке.Вставить("appName", "1CV8C");
	ЗапросИнфоОбОшибке.Вставить("appVersion", "8.3.17.1549");
	ЗапросИнфоОбОшибке.Вставить("configurationInterfaceLanguageCode", "ru");
	ЗапросИнфоОбОшибке.Вставить("systemcrash", "");
	
	ХранилищеДанных.ЗаписатьЗапросИнфоОбОшибке(ЗапросИнфоОбОшибке);
	
	ПутьКВременномуФайлу = ОбъединитьПути(Каталог, "errorInfoRequests.json");
	ЧтениеТекста = Новый ЧтениеТекста(ПутьКВременномуФайлу, "utf-8");
	ПарсерJSON = Новый ПарсерJSON;
	ТелоЗапросаТекст = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();

	Результат = ПарсерJSON.ПрочитатьJSON(ТелоЗапросаТекст);
	
	Ожидаем.Что(Результат.Количество()).Равно(4);
	
КонецПроцедуры

Процедура ТестДолжен_ПолучитьОшибки() Экспорт
	
	Каталог = "data";
	ХранилищеДанных = Новый ФайловоеХранилище(Каталог);
	
	Результат = МенеджерХранилищаОшибок.Инициализировать (ХранилищеДанных, Каталог).ПолучитьОшибки();
	
	Ожидаем.Что(Результат.Колонки.Количество()).Равно(3);
	Ожидаем.Что(Результат.Количество()).Равно(2);
	
КонецПроцедуры

Процедура ТестДолжен_ЗаписатьОшибкуВФайл() Экспорт
	
	Каталог = "data";
	ХранилищеДанных = Новый ФайловоеХранилище(Каталог);
	МенеджерХранилищаОшибок.Инициализировать (ХранилищеДанных, Каталог);

	ЧтениеТекста = Новый ЧтениеТекста("data/55555555-09d5-47b8-bf19-e7672eda1111/report.json", "utf-8");
	ПарсерJSON = Новый ПарсерJSON;
	ТелоЗапросаТекст = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();

	ОтчетОбОшибке = ПарсерJSON.ПрочитатьJSON(ТелоЗапросаТекст);

	ДанныеОтчетаПоОшибке = Новый Структура;
	ДанныеОтчетаПоОшибке.Вставить("Идентификатор", "7054dd5d-f0b8-491d-8dcc-18bc1d2cbc83");
	ДанныеОтчетаПоОшибке.Вставить("Отчет", ОтчетОбОшибке);
	
	ХранилищеДанных.ЗаписатьОшибку(ДанныеОтчетаПоОшибке);
	Результат = МенеджерХранилищаОшибок.ПолучитьОшибки();
	
	Ожидаем.Что(Результат.Количество()).Равно(3);

	НоваяОшибка = Результат[2];

	// Не выполняется на GA
	Ожидаем.Что(НоваяОшибка["fingerprint"]).Равно(ДанныеОтчетаПоОшибке.Идентификатор);
	Ожидаем.Что(НоваяОшибка["external_id"]).Равно("");
	
КонецПроцедуры

Процедура ТестДолжен_СохранитьФайлОтчета() Экспорт
	
	Каталог = "data";
	ХранилищеДанных = Новый ФайловоеХранилище(Каталог);

	ЧтениеДанных = Новый ЧтениеДанных("Ошибка_20201123003806.zip", "utf-8");
	РезультатЧтения = ЧтениеДанных.Прочитать();
	ЧтениеДанных.Закрыть();

	ИдОтчета = "1111-2222-3333333-4444-55555";
	МенеджерХранилищаОшибок.Инициализировать (ХранилищеДанных, Каталог).СохранитьФайлОтчета(ИдОтчета, РезультатЧтения);
	ПутьКОтчету = ОбъединитьПути(Каталог, ИдОтчета);
	Файлы = НайтиФайлы(ПутьКОтчету, "report.json");
	
	Ожидаем.Что(Файлы.Количество()).Равно(1);
	
КонецПроцедуры

Процедура ТестДолжен_УстановитьИдЗадачиВТрекере() Экспорт

	Каталог = "data";
	ХранилищеДанных = Новый ФайловоеХранилище(Каталог);

	ХранилищеДанных.УстановитьИдЗадачиВТрекере("B07F49C8154BA4E20BA3FAAD30507F25", "12345");

	Ошибки = МенеджерХранилищаОшибок.Инициализировать (ХранилищеДанных, Каталог).ПолучитьОшибки();

	Ожидаем.Что(Ошибки.Колонки.Количество()).Равно(3);
	Ожидаем.Что(Ошибки.Количество()).Равно(2);

	Ошибка = Ошибки[1];
	Ожидаем.Что(Ошибка.external_id).Равно("12345");
	
КонецПроцедуры