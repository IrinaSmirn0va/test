const express=require('express');
const mysql2=require('mysql2/promise');
const bodyParser=require('body-parser');

const pool=mysql2.createPool({
	host:'localhost',
	user:'root',
	database:'phonebook',
	password:''
});

const app=express();

app.use(bodyParser.urlencoded({extended:true}));

//главная
app.get('/', async function(req,res){
	const data=await pool.query(`SELECT*FROM abonent`);
	const abonent=data[0];
	res.send(`<!DOCTYPE html>
		<html>
		<body>
		<h1>Корпоративный телефонный справочник</h1>
			<span>Список абонентов</span>   
				
			<ul>
						${abonent.map(abonent=>`
							<li>
								<a href="/abonent-number/${abonent.id_abonent}">${abonent.name}</a> 
							</li>`).join('')}
			</ul>
<a href="/add-abonent">Добавить новый контакт</a>
			
		</body>
		</html>`);
});

//добавление абонента
app.get('/add-abonent', async function(req,res){
	const data=await pool.query(`SELECT*FROM abonent`);
	const abonent=data[0];
	const{name}=req.params;
	res.send(`<!DOCTYPE html>
		<html>
		<body>
			<a href="/">Вернуться к списку абонентов</a>			
			<ul>
						${abonent.map(abonent=>`<li>	${abonent.name} </li>`).join('')}
			</ul>
			<form method="post" action="/add-abonent">
					<input type="text" name="name" placeholder="Введите имя"  />
					<button type="submit">Добавить</button>
			</form>
		</body>
		</html>`);
});

//получение данных о новом абоненте
app.post('/add-abonent', async function(req,res){
	const{id_abonent}=req.params;
	const {name}=req.body;
	await pool.query('INSERT INTO abonent SET?',{
		name:name,
	});
	res.redirect(`/add-abonent`);
});

//отображение номеров конкретного абонента
app.get('/abonent-number/:id_abonent', async function(req,res){
	const{id_abonent}=req.params;
	//const id_abonent=req.params.id_abonent;
	const [number]=await pool.query(`SELECT*FROM number WHERE id_abonent=?`, id_abonent);
	const [[abonent]]=await pool.query(`SELECT*FROM abonent WHERE id_abonent=?`,id_abonent);
	res.send(`<!DOCTYPE html>
		<html>
		<body>
			<h1>Телефонные номера абонента ${abonent.name}</h1>
			<a href="/">Вернуться к списку абонентов</a>			
			<ul>
			  ${number.map(number=>`<li>${number.numberphone} ${number.type || '' } 
			  	<a href="/remove-number/${number.id_number}">Удалить</a>
			  	</li>`).join('')}
			</ul>
			<form method="post" action="/add-number/${id_abonent}">
					<input type="text" name="number" placeholder="Введите номер" />
					<input type="text" name="type" placeholder="Введите тип"  />
					<button type="submit">Добавить</button>
			</form>
		</body>
		</html>`);
});

//удаление номера
app.get('/remove-number/:id_number', async function(req,res){
	const{id_number}=req.params;
	const [[number]]=await pool.query('SELECT * FROM number WHERE id_number=?',id_number);
	await pool.query('DELETE FROM number WHERE id_number=?',id_number);
	res.redirect(`/abonent-number/${number.id_abonent}`);
});

//получение данных
app.post('/add-number/:id_abonent', async function(req,res){
	const{id_abonent}=req.params;
	const {number, type}=req.body;
	await pool.query('INSERT INTO number SET?',{
		id_abonent:id_abonent,
		numberphone:number,
		type:type,
	});
	res.redirect(`/abonent-number/${id_abonent}`);
});

app.listen(process.env.PORT,function(){
	console.log('server start');
});
