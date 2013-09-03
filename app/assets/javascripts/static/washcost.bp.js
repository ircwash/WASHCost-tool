	
	//Fade out Loader when assets loaded, scroll one pixel to reposition background	
	$(window).load(function(){
	    $('#loader').fadeOut(1500);
	    $('#content').fadeIn(200);
	    $('html,body').animate({scrollTop: 1},1);
	    if($(window).scrollTop()<600){
	    	$('#autoplay-wrapper').delay(2500).fadeIn('slow');
	    }
	    //'Learn More' text a condition of window height for all screens
	    var lm = $(window).height() - 50;
	    $('#learnmore').css('margin-top', lm);
	    $('#learnmore').delay(2000).fadeIn('slow');
	});

	//Autoplay functionality
	$('#autoplay-wrapper').click(function(){
		$(this).fadeOut('slow');
		//fade in pause button when clicked
		$('#pause-wrapper').fadeIn('slow');
		var adjust = $(window).scrollTop();
		//duration a condition of scroll position when button is pressed
		var speed = 90000 - adjust;
		$('html,body').animate({scrollTop: 82400}, speed, "linear");
	});

	//pause button breaks .stop(html,body) animation
	$('#pause-wrapper').click(function(){
		$('html,body').stop();
		$(this).fadeOut('slow');
		$('#autoplay-wrapper').fadeIn('slow');
	});

//Document ready
$(function(){
	//Scroll top on refresh
	$('html').animate({scrollTop:0}, 1);
    $('body').animate({scrollTop:0}, 1);

//Navbar functionality:
	//Hover	
	navhover('#problemnav','8em');
	navhover('#lifecyclenav','11em');
	navhover('#calculatornav','12.5em');
	navhover('#breaknav','9em');
	//Scroll to anchor when clicked
	navscroll('#problemnav','8em','sec1');
	navscroll('#lifecyclenav','11em','sec2');
	navscroll('#calculatornav','12.5em','sec3');
	//Scroll to bottom sec4
	$('#breaknav').click(function(){
			$('#navbar li').removeClass('active');
			$('#navbar li').addClass('inactive');
			$('#navbar span').hide();
			$('#navbar li').css('width', '.8em');
			$('#navbar li').css('padding-right', '0em');
			$(this).css('padding-right', '2em');
			$(this).css('width', '9em');
			$('span', this).show();
			$(this).removeClass('inactive');
			$(this).addClass('active');			
		$('html,body').animate({scrollTop: 100000},1000, "linear"); //scroll to the very bottom quickly

	});
			
	//Background img conditionals to prevent stretching slowdown
	if ( $(window).width() > 1900 ){
		$('#large').show().css('width', $(window).width());
	} else if ( $(window).width() > 1600 ) {
		$('#large').show();
	} else if ( $(window).width() > 1400 ) {
		$('#medium').show();
	} else {
		$('#small').show();
	}



	//Superscrollorama		
	var controller = $.superscrollorama();
			
			//BG animation
			controller.pin($('#BG'), 111000, {
				anim: (new TimelineLite())
					.append(				
						TweenMax.fromTo($('#BG'), 28,
							{css:{top:0}},
							{css:{top:-2590}, ease:Linear.easeOut})
					).append(						
						TweenMax.fromTo($('#BG'), 21,
							{css:{top:-2590}},
							{css:{top:-7000},ease:Linear.easeOut})
					).append(						
						TweenMax.fromTo($('#BG'), 18.5,
							{css:{top:-7000}},
							{css:{top:-8900},ease:Linear.easeOut})
					).append(						
						TweenMax.fromTo($('#BG'), 12.5,
							{css:{top:-8900}},
							{css:{top:-12310},ease:Linear.easeOut})
					).append(						
						TweenMax.fromTo($('#BG'), 5,
							{css:{top:-8900}},
							{css:{top:-10010},ease:Linear.easeOut})
					),
				pushFollowers:false
			});

			//"Problem" Section Animations:

			//Arrow animation pin
			controller.pin($('#problemArrow'), 27000, {	anim: (new TimelineLite()).append([	TweenMax.to($('#problemArrow'), 1,{css:{rotation:360}})	]),	pushFollowers:false });

			
			controller.pin($('#inadequate-access'), 1200, {
			offset:-1,						
				anim: (new TimelineLite())
					.append(						
						TweenMax.to($('#inadequate-access'), 2,
							{css:{top:-30}})						
					),
				onPin: function(){
					//hide 'learn more' once scrolling begins
					$('#learnmore').hide();
				}
			});			
			
			controller.pin($('#drinking-water'), 2000, {
				offset:-200,				
				anim: (new TimelineLite())
					.append(
							TweenMax.to($('#drinking-water'), 2,
								{css:{top:170}})
						)
					.append(
							TweenMax.to($('#drinking-water'), .5,
								{css:{top:-350}})
						),
					pushFollowers:false
			});			
			controller.pin($('#sanitation'), 2800, {
				offset:-200,				
				anim: (new TimelineLite())
					.append(
							TweenMax.to($('#sanitation'), 3,
								{css:{top:170}})
						).append(
							TweenMax.to($('#sanitation'), .5,
								{css:{top:-350}})
						),
					pushFollowers:false
			});
			controller.pin($('#tackle'), 2000, {
				offset:-200,				
				anim: (new TimelineLite())
					.append(
							TweenMax.to($('#tackle'), 1,
								{css:{top:170}})
						)
					.append(
							TweenMax.to($('#tackle'), .2,
								{css:{top:-470}})
						),
				pushFollowers:false
			});

			controller.pin($('#dollars'), 2000, {
				offset:-200,				
				anim: (new TimelineLite())
					.append(
							TweenMax.to($('#dollars'), 1,
								{css:{top:30}})
						)
					.append(
							TweenMax.to($('#dollars'), .2,
								{css:{top:-500}})
						),
					pushFollowers:false
			});

			
			controller.pin($('#tenpercent'), 4000, {
				offset:-230,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#tenpercent'), 2,
						{css:{top:190}})
						
					)
					.append(
						TweenMax.to($('#tenpercent'), .4,
						{css:{top:-700}})
						
					),
					pushFollowers:false
			});
			controller.pin($('#droplets'), 9300, {
				offset:-230,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#droplets'), 5,
						{css:{top:200}})
						
					)
					.append(
						TweenMax.to($('#droplets'), .5,
						{css:{top:-400}})
						
					),
					pushFollowers: false
			});
			controller.pin($('#failure'), 2000, {
				offset:-250,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#failure'), 2,
						{css:{top:220}})
						
					)
					.append(
						TweenMax.to($('#failure'), .5,
						{css:{top:-300}})
						
					),
					pushFollowers: false
			});
			controller.pin($('#example'), 2000, {
				offset:-230,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#example'), 2,
						{css:{top:200}})
						
					)
					.append(
						TweenMax.to($('#example'), .5,
						{css:{top:-300}})
						
					),
					pushFollowers: false
			});
			controller.pin($('#example2'), 2000, {
				offset:-250,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#example2'), 2,
						{css:{top:220}})
						
					)
					.append(
						TweenMax.to($('#example2'), .5,
						{css:{top:-300}})
						
					),
					pushFollowers: false
			});
			controller.pin($('#unsafe'), 4000, {
				offset:-230,				
				anim: (new TimelineLite())
					.append([
							TweenMax.to($('#dirtydroplet'), 2,
								{css:{opacity:1}}),
							TweenMax.to($('#unsafe'), 2,
								{css:{top:200}})
							]).append(
								TweenMax.to($('#unsafe'), .5,
								{css:{top:-400}})						
						),
						pushFollowers:false,
						//Extend the next navbar when scrolling to new section and returning
					onPin: function(){
						if ($(document).scrollTop() < 28189 && $(document).scrollTop() > 25000) {
							pinAnimate('#problemnav','8em');	
							}
					},	
					onUnpin: function(){
						if ($(document).scrollTop() > 24167) {
							pinAnimate('#lifecyclenav','11em');	
							}
					}
			});

			//Lifecycle section animations
			controller.pin($('#approach'), 3000, {
				offset:-200,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#approach'), 2,
						{css:{top:100}})						
					).append(
						TweenMax.to($('#approach'), 1,
						{css:{top:-250}})
					),
					pushFollowers:false
			});

			controller.pin($('#circles'), 3100, {
				offset:0,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#circles'), 5,
						{css:{top:-250}})						
					),
					pushFollowers:false
			});
			controller.pin($('#circtext'), 4000, {
				offset:-280,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#circtext'), .5,
						{css:{opacity:1}})
					)
					.append(
						TweenMax.to($('#circtext'), 5,
						{css:{top:200}})						
					).append(
						TweenMax.to($('#circtext'), 2,
						{css:{top:-190}})						
					),
					pushFollowers:false
			});

			
			controller.pin($('#delivery-container'), 2500, {
				offset:3500,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#delivery-container'), 2,
						{css:{top:-3550}})
						
					).append(
						TweenMax.to($('#delivery-container'), 1,
						{css:{top:-4250}})
						
					),
					pushFollowers: false
			});


			//first line animation
			controller.pin($('#line'), 6000, {
				offset:-200,				
				anim: (new TimelineLite())					
					.append(
						TweenMax.to($('#line'), 3,
						{css:{paddingTop:1000}})
					).append(
						TweenMax.to($('#line'), 5,
						{css:{top:-600}})
					).append(
						TweenMax.to($('#line'), 3,
						{css:{paddingTop:1200}})
					).append(
						TweenMax.to($('#line'), 3,
						{css:{top:-1400}})
					),
					pushFollowers:false
			});

			controller.pin($('#circle3-container'), 3500, {
				offset:2991, //padding - room for line				
				anim: (new TimelineLite())
					.append([
						TweenMax.to($('#circle3'), .2,
						{css:{width:280, height:280}}),
						TweenMax.to($('#circle3-container'), 3,
						{css:{top:-2991}})							
					])
					.append(
						TweenMax.to($('#circle3-container'), 1,
						{css:{top:-4100}})	
					),
					pushFollowers:false
			});


			//pie text pin and fade in individually
			controller.pin($('#pie-text'), 5000, {
				offset:305, //padding - room for line				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#t4'), .2,
						{css:{opacity:1}})						
					).append(
						TweenMax.to($('#t5'), .2,
						{css:{opacity:1}})						
					).append(
						TweenMax.to($('#major'), .2,
						{css:{opacity:1}})						
					).append(
						TweenMax.to($('#t3'), .2,
						{css:{opacity:1}})						
					).append(
						TweenMax.to($('#t2'), .2,
						{css:{opacity:1}})						
					)
					.append(
						TweenMax.to($('#t1'), .2,
						{css:{opacity:1}})						
					).append( 

						TweenMax.to($('#pie-text'), 2,
						{css:{opacity:1}})	

					)
					.append( 

						TweenMax.to($('#pie-text'), 2,
						{css:{top:-450}})	

					)
					.append( 

						TweenMax.to($('#pie-text'), 4,
						{css:{top:-450}})	

					).append( 

						TweenMax.to($('#pie-text'), 1,
						{css:{top:-970}})	

					),
					pushFollowers:false
			});

			//pie position condition of window width, updated on resize
			var w = $(window).width() / 2;
			//Pie pieces pin and fly in
			controller.pin($('#pie'), 5000, {
				offset:-266, 			
				anim: (new TimelineLite())
					.append([
							TweenMax.fromTo($('#pie1'), 1.9, 
								{css:{left:2000,top: -3000}, immediateRender:true}, 
								{css:{left:w,top: 0}}),

							TweenMax.fromTo($('#pie2'), 1.85, 
								{css:{top: -3000, left: -2000}, immediateRender:true}, 
								{css:{ top: 0, left:w}}),

							TweenMax.fromTo($('#pie3'), 2, 
								{css:{top:-2000, left: -3000}, immediateRender:true}, 
								{css:{top:0,left:w}}),

							TweenMax.fromTo($('#pie4'), 2.1, 
								{css:{top:1000, left: -3000}, immediateRender:true}, 
								{css:{top:0,left:w}}),

							TweenMax.fromTo($('#pie5'), 1.75, 
								{css:{top:2000, left: -3676}, immediateRender:true}, 
								{css:{top:0,left:w}}),

							TweenMax.fromTo($('#pie6'), 1.95, 
								{css:{top:7000, left: 6000}, immediateRender:true}, 
								{css:{top:0,left:w}})

						// TweenMax.to($('#pie'), 1,
						// {css:{opacity:1}}),
													
					]).append(
					TweenMax.to($('#pie'), 2,
						{css:{top:266}})).append(
					TweenMax.to($('#pie'), 1,
						{css:{top:120}}))
					.append(
					TweenMax.to($('#pie'), 6,
						{css:{top:120}}))
					.append(
					TweenMax.to($('#pie'), 1,
						{css:{top:-700}})),
					pushFollowers:false
			});

			controller.pin($('#aspects'), 6000, {
				offset:1610,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#aspects'), 7,
						{css:{top:-1630}})
						
					)
					.append(
						TweenMax.to($('#aspects'), 2,
						{css:{top:-1900}})
						
					)
					.append(
						TweenMax.to($('#aspects'), 4.5,
						{css:{top:-1950}})
						
					)
					.append(
						TweenMax.to($('#aspects'), .5,
						{css:{top:-2550}})
						
					),
					pushFollowers:false,
					onPin: function() {
						if ($(document).scrollTop() < 46750 && $(document).scrollTop() > 42750) {
							pinAnimate('#lifecyclenav','11em');	
							}
						
					},
					onUnpin: function(){
						if ($(document).scrollTop() > 46666) {
							pinAnimate('#calculatornav','12.5em');	
							}	

					}
			});

			controller.pin($('#calculator-container'), 4000, {
				offset:3500,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#calculator-container'), 2,
						{css:{top:-3550}})
						
					).append(
						TweenMax.to($('#calculator-container'), 1,
						{css:{top:-4500}})
						
					),
					pushFollowers: false
			});
			//second line animation
			controller.pin($('#line2'), 7000, {
				offset:-230,				
				anim: (new TimelineLite())					
					.append(
						TweenMax.to($('#line2'), 3,
						{css:{paddingTop:1000}})
					)
					.append(
						TweenMax.to($('#line2'), 4,
						{css:{top:-600}})
					).append(
						TweenMax.to($('#line2'), 4,
						{css:{paddingTop:3250}})
					).append(
						TweenMax.to($('#line2'), 5,
						{css:{top:-770}})
					)
			});

			
			controller.pin($('#bauble-container'), 9000, {
				offset:3050,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#bauble-container'), 10,
						{css:{top:-3050}})
						
					).append(
						TweenMax.to($('#bauble-container'), 1,
						{css:{top:-3500}})
						
					),
					pushFollowers: false
			});

			controller.pin($('#users-container'), 2500, {
				offset:-170,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#users-container'), 2,
						{css:{top:170}})
						
					).append(
						TweenMax.to($('#users-container'), 2,
						{css:{top:-400}})
						
					),
					pushFollowers:false					
			});

			controller.pin($('#tool-container'), 6060, {
				offset:1820,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#tool-container'), 5,
						{css:{top:-1820}})
						
					).append(
						TweenMax.to($('#tool-container'), .5,
						{css:{top:-2300}})
						
					),
					pushFollowers:false					
			});

			controller.pin($('#sustain-container'), 1000, {
				offset:1300,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#sustain-container'), 1,
						{css:{top:-1305}})
						
					).append(
						TweenMax.to($('#sustain-container'), .5,
						{css:{opacity:0}})
						
					),
					pushFollowers:false					
			});
			controller.pin($('#money-container'), 1200, {
				offset:1300,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#money-container'), 1,
						{css:{top:-1305}})
						
					).append(
						TweenMax.to($('#money-container'), .5,
						{css:{opacity:0}})
						
					),
					pushFollowers:false					
			});

			controller.pin($('#projects-container'), 1000, {
				offset:1300,				
				anim: (new TimelineLite())
					.append(
						TweenMax.to($('#projects-container'), 1,
						{css:{top:-1305}})
						
					).append(
						TweenMax.to($('#projects-container'), .5,
						{css:{opacity:0}})
						
					),
					pushFollowers:false					
			});

			
			controller.pin($('#database-wrapper'), 4500, {
				offset:1850,				
				anim: (new TimelineLite())
					//checkboxes appear
					.append(
						TweenMax.to($('#database-wrapper'), .5,
						{css:{top:-1870}})
					)
					.append(
						TweenMax.to($('#theone'), .5,
						{css:{opacity:1}})
					)
					.append(
						TweenMax.to($('#c1'), .5,
						{css:{opacity:1}})
					)
					.append(
						TweenMax.to($('#c2'), .5,
						{css:{opacity:1}})
					)
					.append(
						TweenMax.to($('#c3'), .5,
						{css:{opacity:1}})
					)
					.append(
						TweenMax.to($('#c4'), .5,
						{css:{opacity:1}})
					)		
					
			});

			controller.pin($('#clock-wrapper'), 3000, {
				offset:200,				
				anim: (new TimelineLite())
					//checkboxes appear
					.append([
						TweenMax.to($('#clock-wrapper'), .5,
						{css:{top:-250}})
												
					])
					.append(
						TweenMax.to($('#clock'), 1,
						{css:{rotation:360}})
					),
					onPin: function(){
						if( !($('#pause-wrapper').is(':visible')) ) {
   							$('#play-wrapper').fadeIn('slow');
						}
						
					}
								
					
			});

			controller.pin($('#report-wrapper'), 5000, {
				offset:420,				
				anim: (new TimelineLite())
					//checkboxes appear
					.append(
						TweenMax.to($('#report-wrapper'), 1,
						{css:{top:-420}})
					)
					.append(
						TweenMax.fromTo($('#expenditure'), .5,
						{css:{opacity:0}, immediateRender:true},
						{css:{opacity:1}})
					)
					.append(
						TweenMax.fromTo($('#level'), .5,
						{css:{opacity:0}, immediateRender:true},
						{css:{opacity:1}})
					)
					.append(
						TweenMax.fromTo($('#costs'), .5,
						{css:{opacity:0}, immediateRender:true},
						{css:{opacity:1}})
					)
						//draw line graph
						.append(
							TweenMax.fromTo($('#l1'), .2,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
						)
						.append(
							TweenMax.fromTo($('#l2'), .2,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
						)
						.append(
							TweenMax.fromTo($('#l3'), .2,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
						)
						.append(
							TweenMax.fromTo($('#l4'), .2,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
						)
					//grow bar graph
					.append([
						TweenMax.fromTo($('#bar1'), .1,
							{css:{height:0}, immediateRender:true},
							{css:{height:40}}),
						TweenMax.fromTo($('#bar2'), .33,
							{css:{height:0}, immediateRender:true},
							{css:{height:28}}),
						TweenMax.fromTo($('#bar3'), .3,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}}),
						TweenMax.fromTo($('#bar4'), .31,
							{css:{height:0}, immediateRender:true},
							{css:{height:50}}),
						TweenMax.fromTo($('#bar5'), .3,
							{css:{height:0}, immediateRender:true},
							{css:{height:18}})
					])			
					//warnings
					.append(
						TweenMax.fromTo($('#w2'), .4,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
					)
					.append([
						TweenMax.fromTo($('#w1'), .4,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}}),
						TweenMax.fromTo($('#w3'), .4,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
					])
					.append(
						TweenMax.fromTo($('#allowing'), 1,
							{css:{opacity:0}, immediateRender:true},
							{css:{opacity:1}})
					).append(
						TweenMax.to($('#allowing'), .8,
							{css:{opacity:1}})
					),
					onPin:function(){
						if ($(window).scrollTop() < 79900 && $(window).scrollTop() > 67900) {
							pinAnimate('#calculatornav','12em');	
							}
					},
					onUnpin: function(){
						$('#play-wrapper').hide();
						if ($(window).scrollTop() > 74770) {
							pinAnimate('#breaknav','9em');	
							}

					}
			});	



	//window resize adjustments
	$(window).resize(function(){

			//bg width
			$('#small, #medium, #large').hide();
			if ( $(window).width() > 1900 ){
				$('#large').show().css('width', $(window).width());
			} else if ( $(window).width() > 1600 ) {
				$('#large').show();
			} else if ( $(window).width() > 1400 ) {
				$('#medium').show();
			} else {
				$('#small').show();
			}				

			//pie location
			var w = $(window).width() / 2;
			controller.updatePin($('#pie'), 5000, {
			offset:-266, 			
			anim: (new TimelineLite())
				.append([
						TweenMax.fromTo($('#pie1'), 1.9, 
							{css:{left:2000,top: -3000}, immediateRender:true}, 
							{css:{left:w,top: 0}}),

						TweenMax.fromTo($('#pie2'), 1.85, 
							{css:{top: -3000, left: -2000}, immediateRender:true}, 
							{css:{ top: 0, left:w}}),

						TweenMax.fromTo($('#pie3'), 2, 
							{css:{top:-2000, left: -3000}, immediateRender:true}, 
							{css:{top:0,left:w}}),

						TweenMax.fromTo($('#pie4'), 2.1, 
							{css:{top:1000, left: -3000}, immediateRender:true}, 
							{css:{top:0,left:w}}),

						TweenMax.fromTo($('#pie5'), 1.75, 
							{css:{top:2000, left: -3676}, immediateRender:true}, 
							{css:{top:0,left:w}}),

						TweenMax.fromTo($('#pie6'), 1.95, 
							{css:{top:7000, left: 6000}, immediateRender:true}, 
							{css:{top:0,left:w}})
												
				]).append(
				TweenMax.to($('#pie'), 2,
					{css:{top:266}})).append(
				TweenMax.to($('#pie'), 1,
					{css:{top:120}}))
				.append(
				TweenMax.to($('#pie'), 6,
					{css:{top:120}}))
				.append(
				TweenMax.to($('#pie'), 1,
					{css:{top:-700}})),
				pushFollowers:false
		});
	});			





}); //end of document ready

	//Functions:

	//Navigation hover animations
	function navhover(el, width){
			$(el).hover(
			function(){
				if($(this).hasClass('inactive')){
					$('span', this).fadeIn(300);
					$(this).css('padding-right', '0em');
					$(this).css('padding-right', '2em');
					$(this).filter(':not(:animated)').animate({
					width: width
					}, 300, "linear");
					
					$(this).addClass('hover');
				}
			}, 
			function(){
				$(this).stop();
				$('span', this).stop();
				if($(this).hasClass('inactive')){
					$(this).css('padding-right', '0em');
					$('span', this).fadeOut(300);
					$(this).filter(':not(:animated)').animate({
						width: '.8em'
					}, 300, "linear");
				$(this).removeClass('hover');
				}	
			}
			);
		}

		function scrollToAnchor(aid){
		    var aTag = $("a[name='"+ aid +"']");
		    $('html,body').animate({scrollTop: aTag.offset().top},2000, "linear");
		    $('#navbar li').stop();
		}

		function navscroll(el,width,anchor){

			$(el).click(function() {
				$('#navbar li').removeClass('active');
				$('#navbar li').addClass('inactive');
				$('#navbar span').hide();
				$('#navbar li').css('width', '.8em');
				$('#navbar li').css('padding-right', '0em');
				$(this).css('padding-right', '2em');
				$(this).css('width', width);
				$('span', this).show();
				$(this).removeClass('inactive');
				$(this).addClass('active');

				scrollToAnchor(anchor);
			});
		}
		function pinAnimate(el,width){
				if($(el).hasClass('inactive')){
					$('#navbar li').finish();
					$('#navbar li').removeClass('active');
					$('#navbar li').addClass('inactive');
					$('#navbar span').hide();
					$('#navbar li').css('width', '.8em');
					$('#navbar li').css('padding-right', '0em');
					$(el).filter(':not(:animated)').animate({
						paddingRight: '2em',
						width: width
						}, 300, "linear");
					$('span', el).show();
					$(el).removeClass('inactive');
					$(el).addClass('active');
					}						
		}

