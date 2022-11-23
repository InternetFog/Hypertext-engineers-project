// Открытие вложенных элементов главного меню (использует tabindex="-1")
const mainNavItems = document.querySelectorAll(".main-navigation > ul > li");
for (let i = 0; i < mainNavItems.length; i++) {
	mainNavItems[i].addEventListener("click", function() { // Открытие при нажатии
		this.focus();
	});
	mainNavItems[i].addEventListener("mouseleave", function() { // Сокрытие при выведении курсора
		this.blur();
	});
}

// Открытие и сокрытие боковой панели
const mainControlViewBtns = document.querySelectorAll(".main-panel-btn.is-menu");
for (let i = 0; i < mainControlViewBtns.length; i++) {
	mainControlViewBtns[i].addEventListener("click", function() {
		let mainControlPanel = document.querySelector(".main-control-panel");
		mainControlPanel.classList.toggle("hidden");
		mainControlPanel.classList.toggle("shown");
		let mainNavMenu = document.querySelector(".main-navigation");
		mainNavMenu.classList.toggle("mobile-hidden");
		mainNavMenu.classList.toggle("mobile-shown");
		document.querySelector(".main-panel-lang-btn-block").classList.remove("opened");
	});
}

// Открытие и сокрытие панели переключения языков
document.querySelector(".main-panel-lang-btn-block").addEventListener("click", function() {
	this.classList.toggle("opened");
});

// Переключение языков на боковой панели
const langBtns = document.querySelectorAll(".main-panel-btn.is-lang-settings");
for (let i = 0; i < langBtns.length; i++) {
	langBtns[i].addEventListener("click", function() {
		if(!this.classList.contains("current-lang")) {
			document.querySelector(".main-panel-btn.is-lang-settings.current-lang").classList.remove("current-lang");
			this.classList.add("current-lang");
		}
	});
}

// Открытие формы поиска
document.querySelector(".main-panel-btn.is-search").addEventListener("click", function() {
	let searchForm = 	document.querySelector(".search-form");
	let searchInput = document.querySelector(".search-input")
	searchForm.classList.add("opened");
	searchInput.focus();
	searchInput.addEventListener("blur", function() {
		setTimeout(() => {
			searchForm.classList.remove("opened");
		}, 400);
	});
});