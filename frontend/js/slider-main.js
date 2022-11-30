const mainSlider = {
	items: document.querySelectorAll(".main-slider_content-item"),
	dots: document.querySelectorAll(".slider-dot"),
	count: document.querySelectorAll(".main-slider_content-item").length,
	slide: function(n) {
		let current = document.querySelector(".main-slider_content-item.current");
		let currentDot = document.querySelector(".slider-dot.current");
		let currentCount;
		for (let i = 0; i < mainSlider.count; i++) {
			if(mainSlider.items[i] == current) {
				mainSlider.items[i].classList.remove("current");
				currentCount = i + n;
				break;
			}
		}
		if (currentCount > mainSlider.count-1) {
			currentCount = 0;
		} else if (currentCount < 0) {
			currentCount = mainSlider.count;
		}
		current.classList.remove("current");
		currentDot.classList.remove("current");
		mainSlider.items[currentCount].classList.add("current");
		mainSlider.dots[currentCount].classList.add("current");
		mainSlider.refreshBgImg();
	},
	choose: function(n) {
		document.querySelector(".main-slider_content-item.current").classList.remove("current");
		document.querySelector(".slider-dot.current").classList.remove("current");
		mainSlider.items[n].classList.add("current");
		mainSlider.dots[n].classList.add("current");
		mainSlider.refreshBgImg();
	},
	refreshBgImg: function() {
		let src = document.querySelector(".main-slider_content-item.current .main-slider_image-block img").getAttribute("src");
		document.querySelector(".main-slider-background").setAttribute("style", `background: url(${src}) center;`)
	},
}

// Переключение слайдов
for (let i = 0; i < mainSlider.count; i++) {
	mainSlider.dots[i].addEventListener("click", function() {
		if(!this.classList.contains("current")) {
			mainSlider.choose(i);
		}
	});
}

// Автопролистывание слайдера
setInterval(function() {
	mainSlider.slide(1);
}, 10000);