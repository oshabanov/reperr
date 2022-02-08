#Использовать "../src/model"

// BSLLS:UnusedParameters-off
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
// BSLLS:UnusedParameters-on
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_СформироватьТелоЗапросаJira");

	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	
	УстановитьТекущийКаталог(ТекущийСценарий().Каталог);
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Процедура ТестДолжен_СформироватьТелоЗапросаJira() Экспорт
	
	ПровайдерИнтеграцииJira = Новый ПровайдерИнтеграцииJira()
												.URL("url")
												.Логин("login")
												.Токен("APIKey")
												.КлючПроекта("project-id")
												.ИдТипаЗадачи("1")
												.СрокИсполнения(2)
												;

	ДанныеОтчетаОбОшибке = МенеджерХранилищаОшибок.Инициализировать (Неопределено, "../features/fixtures/data")
															.ПолучитьДанныеОтчетаОбОшибке ("61001a5e-09d5-47b8-bf19-e7672eda10e5");
	Результат = ПровайдерИнтеграцииJira.СформироватьТелоЗапроса(ДанныеОтчетаОбОшибке);
	
	СрокИсполнения = СтрШаблон ("""duedate"": ""%1"",", ЗаписатьДатуJSON (ТекущаяДата () + 24 * 3600 * 2));
	Результат = СтрЗаменить (Результат, СрокИсполнения, "");
	
	КаталогСценария = ТекущийСценарий().Каталог;
	ЧтениеТекста = Новый ЧтениеТекста("../features/fixtures/requestBodyJira.json", "utf-8");
	Эталон = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	Ожидаем.Что(Результат).Равно(Эталон);
	
КонецПроцедуры
