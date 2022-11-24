var tableWindow = {
	containers: {
		left: document.querySelector(".time-table-block.left"),
		right: document.querySelector(".time-table-block.right"),
	},
	list: {
		struct: `
		<div class="time-table-heading-block">
			<div class="time-table-heading-btn is-back">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24.03"><path id="arrow-left" d="M28,16.008H12.818l6.6-6.583a2.009,2.009,0,1,0-2.841-2.841l-10,10a2.068,2.068,0,0,0,0,2.841l10,10a2.009,2.009,0,1,0,2.841-2.841l-6.6-6.583H28a2,2,0,0,0,0-4Z" transform="translate(-6.005 -5.996)" fill="#f7f7f7"/></svg>
			</div>
			<h2 class="time-table-heading">Преподаватели</h2>
		</div>
		<div class="time-table-content-block">
			<div class="time-table-search-block">
				<input class="time-table-search-input" type="text" placeholder="Номер группы" value="" />
				<div class="time-table-search-btn">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21.71,20.29,18,16.61A9,9,0,1,0,16.61,18l3.68,3.68a1,1,0,0,0,1.42,0A1,1,0,0,0,21.71,20.29ZM11,18a7,7,0,1,1,7-7A7,7,0,0,1,11,18Z"/></svg>
				</div>
			</div>
			<div class="time-table-radio-box-block">
				<span class="time-table-radio-box_heading">Курс</span>
				<div class="time-table-radio-box">
					<div class="time-table-radio-box-item checked"><span>1</span></div>
					<div class="time-table-radio-box-item"><span>2</span></div>
					<div class="time-table-radio-box-item"><span>3</span></div>
					<div class="time-table-radio-box-item"><span>4</span></div>
					<div class="time-table-radio-box-item"><span>5</span></div>
					<div class="time-table-radio-box-item"><span>6</span></div>
				</div>
			</div>
			<div class="time-table-list-block">
				<span class="time-table-list-block-heading">Факультет</span>
				<ul class="time-table-list">
					<li>
						<span>Прочее</span>
						<ul>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
						</ul>
					</li>
					<li>
						<span>Факультет экологии, сервиса, технологии и дизайна</span>
						<ul>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
						</ul>
					</li>
					<li>
						<span>Институт пищевой инженерии и биотехнологии</span>
						<ul>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
						</ul>
					</li>
					<li>
						<span>Строительный факультет</span>
						<ul>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
							<li><span>Алексеева И.А.</span></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		`,
		dinamicUI: function() {
			let timeTableHeadingBtn = document.querySelectorAll(".time-table-heading-btn");
			for (let i = 0; i < timeTableHeadingBtn.length; i++) {
				timeTableHeadingBtn[i].addEventListener("click", function() {
					if(this.classList.contains('is-back')) {
						tableWindow.closeLast(1);
					} else if(this.classList.contains('is-close')) {
						tableWindow.closeLast(2);
					}
				});
			}

			let radioBoxBtns = document.querySelectorAll(".time-table-radio-box-item");
			for (let i = 0; i < radioBoxBtns.length; i++) {
				radioBoxBtns[i].addEventListener("click", function() {
					document.querySelector(".time-table-radio-box-item.checked").classList.remove('checked');
					this.classList.toggle('checked');
				});
			}

			let listItems = document.querySelectorAll(".time-table-list li");
			for (let i = 0; i < listItems.length; i++) {
				listItems[i].addEventListener("click", function() {
					let opeledItem = document.querySelector(".time-table-list li.opened");
					if(opeledItem != null) 
						opeledItem.classList.remove('opened');
					this.classList.toggle('opened');
					if(this.querySelector("ul") == null) 
						tableWindow.create('table');
				});
			}
		},
	},
	table: {
		struct: `
		<div class="time-table-heading-block">
			<div class="time-table-heading-btn is-back">
				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24.03" viewBox="0 0 24 24.03">
					<path id="arrow-left" d="M28,16.008H12.818l6.6-6.583a2.009,2.009,0,1,0-2.841-2.841l-10,10a2.068,2.068,0,0,0,0,2.841l10,10a2.009,2.009,0,1,0,2.841-2.841l-6.6-6.583H28a2,2,0,0,0,0-4Z" transform="translate(-6.005 -5.996)" fill="#f7f7f7"/>
				</svg>
			</div>
			<h2 class="time-table-heading">Б102-1</h2>
		</div>
		<div class="time-table-content-block">
			<div class="time-table-content-bkock_week-wrapper">
				<div class="week-wrapper_about-style about-text-style active ">
					<span>1 Неделя (текущая)</span>
				</div>
				<div class="week-wrapper_about-style about-text-style">
					<span>2 Неделя</span>
				</div>
			</div>
			<div class="time-table-content-block_schedule-wrap">
				<div class="schedule-wrap_day">
					<div class="schedule-wrap_day-head-block active">
						<p class="about-text-style">Понедельник</p>
						<div class="schedule-wrap_day-head-block_hide-arr">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="7.111" viewBox="0 0 12 7.111">
								<path id="angle-down" d="M18.417,9.21a1.138,1.138,0,0,0-1.605,0l-4.087,4.03L8.7,9.21a1.139,1.139,0,1,0-1.605,1.616l4.827,4.827a1.138,1.138,0,0,0,1.616,0l4.884-4.827a1.138,1.138,0,0,0,0-1.616Z" transform="translate(18.754 15.99) rotate(180)" fill="#138c9d"/>
							</svg>									  
						</div>
					</div>
					<div class="schedule-wrap_day_schedule">
						<div class="schedule-wrap_day_schedule_block active">
							<div class="schedule_block_time">
								<div class="schedule_block_time_number">1</div>
								<div class="schedule_block_time_clock-wrap">
									<span>9:00</span>
									<span>10:35</span>
								</div>
							</div>
							<div class="about-content-wrapper">
								<div class="scheldule_block_lesson-wrapp scheldule_block-about">
									<div class="lesson-style scheldule_block_lesson-wrapp_content">
										<p>лек.История</p>
									</div>
								</div>
								<div class="scheldule_block_link-name scheldule_block-about">
									<div class="scheldule_block_lesson-wrapp_content">
										<a href="#">МАНШЕЕВ Д.М</a>
									</div>
								</div>
								<div class="scheldule_block-about">
									<div class="group-wrapper scheldule_block_lesson-wrapp_content">
										<p class="group-wrapper-text">а.15-462</p>
									</div>
								</div>
							</div>
							<div class="change-btn">(изм.)</div>
						</div>
						<div class="schedule-wrap_day_schedule_block remove">
							<div class="schedule_block_time">
								<div class="schedule_block_time_number">2</div>
								<div class="schedule_block_time_clock-wrap">
									<span>10:45</span>
									<span>12:20</span>
								</div>
							</div>
							<div class="about-content-wrapper">
								<div class="scheldule_block_lesson-wrapp scheldule_block-about">
									<div class="lesson-style scheldule_block_lesson-wrapp_content">
										<p>лек.История</p>
									</div>
								</div>
								<div class="scheldule_block_link-name scheldule_block-about">
									<div class="scheldule_block_lesson-wrapp_content">
										<a href="#">МАНШЕЕВ Д.М</a>
									</div>
								</div>
								<div class="scheldule_block-about">
									<div class="group-wrapper scheldule_block_lesson-wrapp_content">
										<p class="group-wrapper-text">а.15-462</p>
									</div>
								</div>
							</div>
							<div class="change-btn">
								(изм.)
							</div>

							<!-- блок востановить -->

							<div class="remote-block">
								<p>Вы отменили пару</p>
								<button>Восстановить</button>
							</div>
						</div>

						<div class="schedule-wrap_day_schedule_block active">
							<div class="schedule_block_time">
								<div class="schedule_block_time_number">
									3
								</div>
								<div class="schedule_block_time_clock-wrap active">
									<span>13:00</span>
									<span>14:35</span>
								</div>
							</div>
							<div class="about-content-wrapper">
								<div class="scheldule_block_lesson-wrapp scheldule_block-about">
									<div class="lesson-style scheldule_block_lesson-wrapp_content">
										<p>лек.История</p>
									</div>
								</div>
								<div class="scheldule_block_link-name scheldule_block-about">
									<div class="scheldule_block_lesson-wrapp_content">
										<a href="#">МАНШЕЕВ Д.М</a>
									</div>
								</div>
								<div class="scheldule_block-about">
									<div class="group-wrapper scheldule_block_lesson-wrapp_content">
										<p class="group-wrapper-text">а.15-462</p>
									</div>
								</div>
							</div>
							<div class="change-btn">
								(изм.)
							</div>
						</div>
						
						<div class="schedule-wrap_day_schedule_block active change"> 
							<div class="schedule_block_time">
								<div class="schedule_block_time_number active">
									4
								</div>
								<div class="schedule_block_time_clock-wrap">
									<span>14:45</span>
									<span>16:20</span>
								</div>
							</div>
							<div class="about-content-wrapper">
								<div class="scheldule_block_lesson-wrapp scheldule_block-about">
									<div class="lesson-style scheldule_block_lesson-wrapp_content">
										<p>лек.История</p>
									</div>
								</div>
								<div class="scheldule_block_link-name scheldule_block-about">
									<div class="scheldule_block_lesson-wrapp_content">
										<a href="#">МАНШЕЕВ Д.М</a>
									</div>
								</div>
								<div class="scheldule_block-about">
									<div class="group-wrapper scheldule_block_lesson-wrapp_content">
										<p class="group-wrapper-text">а.15-462</p>
									</div>
								</div>
							</div>
							<div class="change-btn">
								(изм.)
							</div>
						</div>
						<div class="schedule-wrap_day_schedule_block">
							<div class="schedule_block_time">
								<div class="schedule_block_time_number">
									5
								</div>
								<div class="schedule_block_time_clock-wrap">
									<span>16:25</span>
									<span>18:00</span>
								</div>
							</div>
							<div class="about-content-wrapper">
								<div class="scheldule_block_lesson-wrapp scheldule_block-about">
									<div class="lesson-style scheldule_block_lesson-wrapp_content">
										<p>лек.История</p>
									</div>
								</div>
								<div class="scheldule_block_link-name scheldule_block-about">
									<div class="scheldule_block_lesson-wrapp_content">
										<a href="#">МАНШЕЕВ Д.М</a>
									</div>
								</div>
								<div class="scheldule_block-about">
									<div class="group-wrapper scheldule_block_lesson-wrapp_content">
										<p class="group-wrapper-text">а.15-462</p>
									</div>
								</div>
							</div>
							<div class="change-btn">
								(изм.)
							</div>
						</div>


						<div class="schedule-wrap_day_schedule_block active">
							<div class="schedule_block_time">
								<div class="schedule_block_time_number">
									6
								</div>
								<div class="schedule_block_time_clock-wrap active">
									<span>18:05</span>
									<span>19:40</span>
								</div>
							</div>
							<div class="about-content-wrapper">
								<div class="scheldule_block_lesson-wrapp scheldule_block-about">
									<div class="lesson-style scheldule_block_lesson-wrapp_content">
										<p>лек.История</p>
									</div>
								</div>
								<div class="scheldule_block_link-name scheldule_block-about">
									<div class="scheldule_block_lesson-wrapp_content">
										<a href="#">МАНШЕЕВ Д.М</a>
									</div>
								</div>
								<div class="scheldule_block-about">
									<div class="group-wrapper scheldule_block_lesson-wrapp_content">
										<p class="group-wrapper-text">а.15-462</p>
									</div>
								</div>
							</div>
								<div class="change-btn">
									(изм.)
								</div>										
						</div>
					</div>
				</div>
				<div class="schedule-wrap_day">
					<div class="schedule-wrap_day-head-block">
						<p class="about-text-style">Вторник</p>
						<div class="schedule-wrap_day-head-block_hide-arr">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="7.111" viewBox="0 0 12 7.111">
								<path id="angle-down" d="M18.417,9.21a1.138,1.138,0,0,0-1.605,0l-4.087,4.03L8.7,9.21a1.139,1.139,0,1,0-1.605,1.616l4.827,4.827a1.138,1.138,0,0,0,1.616,0l4.884-4.827a1.138,1.138,0,0,0,0-1.616Z" transform="translate(18.754 15.99) rotate(180)" fill="#138c9d"/>
							</svg>									  
						</div>
					</div>
				</div>
				<div class="schedule-wrap_day">
					<div class="schedule-wrap_day-head-block">
						<p class="about-text-style">Среда</p>
						<div class="schedule-wrap_day-head-block_hide-arr">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="7.111" viewBox="0 0 12 7.111">
								<path id="angle-down" d="M18.417,9.21a1.138,1.138,0,0,0-1.605,0l-4.087,4.03L8.7,9.21a1.139,1.139,0,1,0-1.605,1.616l4.827,4.827a1.138,1.138,0,0,0,1.616,0l4.884-4.827a1.138,1.138,0,0,0,0-1.616Z" transform="translate(18.754 15.99) rotate(180)" fill="#138c9d"/>
							</svg>									  
						</div>
					</div>
				</div>
				<div class="schedule-wrap_day">
					<div class="schedule-wrap_day-head-block">
						<p class="about-text-style">Четверг</p>
						<div class="schedule-wrap_day-head-block_hide-arr">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="7.111" viewBox="0 0 12 7.111">
								<path id="angle-down" d="M18.417,9.21a1.138,1.138,0,0,0-1.605,0l-4.087,4.03L8.7,9.21a1.139,1.139,0,1,0-1.605,1.616l4.827,4.827a1.138,1.138,0,0,0,1.616,0l4.884-4.827a1.138,1.138,0,0,0,0-1.616Z" transform="translate(18.754 15.99) rotate(180)" fill="#138c9d"/>
							</svg>									  
						</div>
					</div>
				</div>
				<div class="schedule-wrap_day">
					<div class="schedule-wrap_day-head-block">
						<p class="about-text-style">Пятница</p>
						<div class="schedule-wrap_day-head-block_hide-arr">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="7.111" viewBox="0 0 12 7.111">
								<path id="angle-down" d="M18.417,9.21a1.138,1.138,0,0,0-1.605,0l-4.087,4.03L8.7,9.21a1.139,1.139,0,1,0-1.605,1.616l4.827,4.827a1.138,1.138,0,0,0,1.616,0l4.884-4.827a1.138,1.138,0,0,0,0-1.616Z" transform="translate(18.754 15.99) rotate(180)" fill="#138c9d"/>
							</svg>									  
						</div>
					</div>
				</div>
				<div class="schedule-wrap_day">
					<div class="schedule-wrap_day-head-block">
						<p class="about-text-style">Суббота</p>
						<div class="schedule-wrap_day-head-block_hide-arr">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="7.111" viewBox="0 0 12 7.111">
								<path id="angle-down" d="M18.417,9.21a1.138,1.138,0,0,0-1.605,0l-4.087,4.03L8.7,9.21a1.139,1.139,0,1,0-1.605,1.616l4.827,4.827a1.138,1.138,0,0,0,1.616,0l4.884-4.827a1.138,1.138,0,0,0,0-1.616Z" transform="translate(18.754 15.99) rotate(180)" fill="#138c9d"/>
							</svg>									  
						</div>
					</div>
				</div>
			</div>
		</div>
		`,
		dinamicUI: function() {
			return true;
		},
	},
	detailed: {
		struct:  `
		<div class="time-table-heading-block">
			<div class="time-table-heading-btn is-multiply">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M13.41,12l6.3-6.29a1,1,0,1,0-1.42-1.42L12,10.59,5.71,4.29A1,1,0,0,0,4.29,5.71L10.59,12l-6.3,6.29a1,1,0,0,0,0,1.42,1,1,0,0,0,1.42,0L12,13.41l6.29,6.3a1,1,0,0,0,1.42,0,1,1,0,0,0,0-1.42Z"/></svg>
			</div>
			<h2 class="time-table-heading">Пятница, 2 пара</h2>
		</div>
		<div class="time-table-content-block">
			<div class="time-table-content-bkock_week-wrapper">
				<div class="week-wrapper_about-style about-text-style active">
					<span>План корпуса</span>
				</div>
				<div class="week-wrapper_about-style about-text-style">
					<span>Карта</span>
				</div>
			</div>
			<img class="campus-img" src="images/examples/campus.jpg" alt="То, что мы не успели реализовать">
			<div class="time-table-editor">
				<div class="time-n-control-wrapper">
					<div class="time-table-editor_time-block">
						<div class="number"><span>2</span></div>
						<div class="time"><span>10:45</span><span>12:20</span></div>
					</div>
					<div class="time-table-editor_control-block">
						<div class="time-table-editor_control-btn">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/></svg>
						</div>
						<div class="time-table-editor_control-btn">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,7.24a1,1,0,0,0-.29-.71L17.47,2.29A1,1,0,0,0,16.76,2a1,1,0,0,0-.71.29L13.22,5.12h0L2.29,16.05a1,1,0,0,0-.29.71V21a1,1,0,0,0,1,1H7.24A1,1,0,0,0,8,21.71L18.87,10.78h0L21.71,8a1.19,1.19,0,0,0,.22-.33,1,1,0,0,0,0-.24.7.7,0,0,0,0-.14ZM6.83,20H4V17.17l9.93-9.93,2.83,2.83ZM18.17,8.66,15.34,5.83l1.42-1.41,2.82,2.82Z"/></svg>
						</div>
					</div>
				</div>
				<div class="couple-wrapper">
					<div class="couple-field">
						<span class="couple-field-heading">Предмет</span>
						<span class="couple-field-val">лек.История</span>
					</div>
					<div class="couple-field">
						<span class="couple-field-heading">Преподаватель</span>
						<a href class="couple-field-val">МАНШЕЕВ Д.М </a>
					</div>
					<div class="couple-field">
						<span class="couple-field-heading">Аудитория</span>
						<span class="couple-field-val">а.15-462</span>
					</div>
				</div>
				<textarea class="time-table-editor_textarea" placeholder="Заметка"></textarea>
			</div>
		</div>
		`,
		dinamicUI: function() {
			return true;
		},
	},

	create: function(structType) {
		mainParent = document.createElement("div");
		mainParent.classList.add("time-table-window");
		switch(structType) {
			case 'list':
				mainParent.innerHTML = tableWindow.list.struct;
				tableWindow.containers.left.append(mainParent);
				tableWindow.list.dinamicUI();
			break;
			case 'table':
				mainParent.innerHTML = tableWindow.table.struct;
				tableWindow.containers.left.append(mainParent);
				tableWindow.table.dinamicUI();
			break;
			case 'detailed':
				mainParent.innerHTML = tableWindow.detailed.struct;
				tableWindow.containers.right.append(mainParent);
				tableWindow.detailed.dinamicUI();
			break;
		}
	},
	closeLast(tableNum) {
		switch(tableNum) {
			case 1: 
				tableWindow.containers.left.querySelector('.time-table-window:last-child').remove();
			break;
			case 2: 
				tableWindow.containers.right.querySelector('.time-table-window:last-child').remove();
			break;
		}
	}
}

const timeTableMainMenu = document.querySelectorAll(".time-table-main-menu_btn.filled");
for (let i = 0; i < timeTableMainMenu.length; i++) {
	timeTableMainMenu[i].addEventListener("click", function() {
		tableWindow.create('list');
	});
}