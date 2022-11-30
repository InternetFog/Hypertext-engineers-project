
// Объект карусели
let carousel = {
	carouselBtn: document.querySelectorAll(".carousel-btn"),
	carouselDragOb: document.querySelectorAll(".carousel-block"),
	cardWidth: document.querySelector(".publication-card").offsetWidth,
	cardShiftWidth: null,
	dragEvent: null,
	allowDrag: false,
	isDrag: false,
	// Сдвиг карточек (значение сдвига хранится в атрибуте "card-shift")
	slide: function(carouselWrapOb, n) {
		let carouselBlockOb = carouselWrapOb.querySelector(".carousel-block");
		let cardShift = Number(carouselBlockOb.getAttribute("card-shift"));
		let cardsCount = carouselBlockOb.querySelectorAll(".publication-card").length;
		let visibleCardCount = Math.round(carouselWrapOb.offsetWidth / carousel.cardWidth);
		cardShift += n;

		// Ограничение пролистывания карусели при минимальном и максимальном значении
		let btnPlus = carouselWrapOb.querySelector(".carousel-btn.plus");
		let btnMinus = carouselWrapOb.querySelector(".carousel-btn.minus");
		if(btnPlus) {
			if (cardShift >= cardsCount-visibleCardCount) { 
				cardShift = cardsCount-visibleCardCount;
				btnPlus.classList.remove("visible");
			} else  {
				btnPlus.classList.add("visible");
			}
		}
		if(btnMinus) {
			if (cardShift <= 0) {
				cardShift = 0;
				btnMinus.classList.remove("visible");
			} else {
				btnMinus.classList.add("visible");
			}
		}
		carouselBlockOb.setAttribute("card-shift", cardShift); // Сохранение значения сдвига
		carouselBlockOb.style.left = -cardShift*(carousel.cardWidth+15)+"px"; // Сдвиг
	},

	dragChecking: function(thisOb, e) {
		
	},

	// Действия при начале сдвига (при нажатии мышью или при касании)
	dragStart: function(thisOb, e) {
		if(!(thisOb.classList.contains("only-mobile")) || (thisOb.classList.contains("only-mobile") && document.documentElement.clientWidth <= 1245)) {
			carousel.dragEvent = e;
			thisOb.style.transition = "none";
			carousel.allowDrag = true;
		}
	},
	// Действия при перемещении курсора или свайпе
	dragMoving: function(thisOb, e) {
		if (carousel.allowDrag) {
			carousel.isDrag = true;
			if(e.type == "touchmove") {
				thisOb.style.transform = "translateX("+Number(e.touches[0].pageX - carousel.dragEvent.touches[0].pageX)+"px)";
				carousel.cardShiftWidth = e.touches[0].pageX - carousel.dragEvent.touches[0].pageX;
			} else {
				thisOb.style.transform = "translateX("+Number(e.pageX - carousel.dragEvent.pageX)+"px)";
			}
		}
	},
	// Действия при прекращении нажатия мыши или касания
	dragEnd: function(thisOb, e) {
		if (carousel.allowDrag) {
			let carouselWrapOb = thisOb.closest(".publication-cards-wrapper");
			let cardShiftWidth = carousel.dragEvent.pageX - e.pageX;
			let cardShift;
			if(e.type == ("mouseup" || "mouseleave")) {		
				cardShift = Math.round(cardShiftWidth/carousel.cardWidth);
				carousel.slide(carouselWrapOb, cardShift);
			} else {
				cardShift = carousel.cardShiftWidth;
				if(cardShift > 0) {
					carousel.slide(carouselWrapOb, -1);
				} else {
					carousel.slide(carouselWrapOb, 1);
				}
			}
			thisOb.style.transform = "";
			thisOb.style.transition = "";
			carousel.dragEvent = null;
			carousel.allowDrag = false;
			setTimeout(function(){carousel.isDrag = false}, 1);
		}
	},
}

// Перелистывание карусели нажатием на кнопку
for (let i = 0; i < carousel.carouselBtn.length; i++) {
	carousel.carouselBtn[i].addEventListener("click", function() {
		let carouselWrapOb = this.closest(".publication-cards-wrapper");
		if(this.classList.contains("plus")) {
			carousel.slide(carouselWrapOb, 1)
		} else if (this.classList.contains("minus")) {
			carousel.slide(carouselWrapOb, -1)
		}
	});
}

// Перелистывание карусели свайпом или перетаскиванием
for (let i = 0; i < carousel.carouselDragOb.length; i++) {
	// Для перетаскивания мышью
	carousel.carouselDragOb[i].addEventListener("mousedown", function(e) {
		carousel.dragStart(this, e);
	});
	carousel.carouselDragOb[i].addEventListener("mousemove", function(e) {
		carousel.dragMoving(this, e);
	});
	carousel.carouselDragOb[i].addEventListener("mouseup", function(e) {
		carousel.dragEnd(this, e);
	});
	carousel.carouselDragOb[i].addEventListener("mouseleave", function(e) {
		carousel.dragEnd(this, e);
	});

	// Для перетаскивания свайпом
	carousel.carouselDragOb[i].addEventListener("touchstart", function(e) {
		carousel.dragStart(this, e);
	});
	carousel.carouselDragOb[i].addEventListener("touchmove", function(e) {
		carousel.dragMoving(this, e);
	});
	carousel.carouselDragOb[i].addEventListener("touchend", function(e) {
		carousel.dragEnd(this, e);
	});

	// Отмена перехода по ссылке при перетаскивании
	carousel.carouselDragOb[i].addEventListener("click", function(e) {
		if(carousel.isDrag) {
			e.preventDefault(e);
		} else {
			e.preventDefault();
			carousel.dragEnd(this, e);
			let link = e.target.getAttribute('href');
			if(link !== null) {location.href = link;}
		}
	});
}