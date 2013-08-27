
homeSlide = {
//dimension properties
footerHeight: 329, //resets onload
headerHeight: 105, //resets onload
navArrowHeight: 86, //Have to set here because they are not visible
winWidth: 1024, //resets onload
slideWidth: 1400, //resets onload / only different in portait mode (typically tablets)
winHeight: 768, //resets onload
slideHeight: 600,
slideLeftOffset: 0, //used in portrait mode otherwise 0
slideTopMargin: 0, //reset on load and resize
//minPageHeight: 700, reset onload and on resize
minSlideWidth: 1000, //900px + 10 on each side to show bleed and more image.
//ratios to set up slideshow for the optimal display
imgRatio: 0.625, //height to width ratio of slide images 875/1400
slideScreenRatio: .87, //optimal slide to screen height ratio short screens ( 80% is slide )
//slideshow properties
firstInterval: 4000000, //millisecond interval before the first slide action NOTE that this fires after all images are loaded. (Temporarily increased from 4000 to 4000000).
interval: 7500, //millisecond interval between slides.
duration: 1, //amount of time to complete the animation NOTE only used in scriptaculous animation
currentSlide: 1,
currentPos: 0, //reset to the current slide x position
loadedImages: 0,
isSliding: false,
playSlideshow: true, //whether or not to restart the slideshow
setup: function(){
if(screen.width > screen.height && screen.width < 560) {
document.body.addClassName('mobile');
}
homeSlide.updateCaption(0);
homeSlide.headerHeight = $('navWrapper').getHeight();
homeSlide.footerHeight = $('footer').getHeight() - $('footerfitzroy').getHeight(); //29 is the height of the mountains and shadow
homeSlide.resizeSlides();
window.onresize = function() {
homeSlide.resizeSlides();
};
document.observe('keydown', function(e){
if(e.keyCode == 37){
//prev
homeSlide.prevNext(-1);
}
if(e.keyCode == 39){
//next
homeSlide.prevNext(1);
}
});
},
resizeSlides: function(){
homeSlide.winWidth =  document.viewport.getWidth();
homeSlide.winHeight = document.viewport.getHeight();
homeSlide.slideHeight =  $('homeslideposition').getHeight();
homeSlide.slideWidth = homeSlide.winWidth;
if(homeSlide.slideWidth < homeSlide.minSlideWidth) {
homeSlide.slideWidth =homeSlide.minSlideWidth;
}
var slideAreaRatio = homeSlide.slideHeight / homeSlide.slideWidth;
var imgHeight = homeSlide.slideWidth * homeSlide.imgRatio;
var imgOffset = 0;
if(homeSlide.slideHeight <= imgHeight){ //Landscape
var imgOffset = ((imgHeight - homeSlide.slideHeight) / 2) * -1;
slides.each(function(el){
var slideHTML = el.html;
el.html = slideHTML.replace(/style="[^"\r\n]*"/,'style="margin-top: ' +  imgOffset + 'px;"');
});
$$('.homeslidediv').each(function(el){
el.style.marginTop =  imgOffset + 'px';
el.style.marginLeft =  '0px';
el.style.width =  'auto';
});
} else
if (homeSlide.slideHeight > imgHeight){ //portait
var divWidth = homeSlide.slideHeight / homeSlide.imgRatio;
var divMarginLeft = ((divWidth - homeSlide.slideWidth) / 2) * -1;
slides.each(function(el){
var slideHTML = el.html;
el.html = slideHTML.replace(/style="[^"\r\n]*"/,'style="width: ' + divWidth + 'px; margin-left: ' +  divMarginLeft + 'px;"')
});
$$('.homeslidediv').each(function(el){
el.style.marginTop =  '0px';
el.style.marginLeft =  divMarginLeft + 'px';
el.style.width =  divWidth + 'px';
});
}
var slideNavTop = homeSlide.slideHeight - 59; //position nav circles 40px above the footer
$('homeslidenavlinks').style.top = slideNavTop + 'px';
$('photoposition').style.top = homeSlide.slideHeight + 'px';
var arrowPos = (((homeSlide.slideHeight - homeSlide.headerHeight) / 2) - (homeSlide.navArrowHeight / 2)) + homeSlide.headerHeight;
$('navarrowleft').style.top = arrowPos + 'px';
$('navarrowright').style.top = arrowPos + 'px';
},
updateCaption: function(idx){
/*if($('homephotocredits').style.display != 'none'){
$('homephotocredits').fade({
duration: .3,
afterFinish: function(){
if(slides[idx].caption != '' || slides[idx].photog != '') {
$('homephotocaption').innerHTML = slides[idx].caption + '<div class="photoBy">' + slides[idx].photog + '</div>';
$('homephotocredits').appear({duration: .3});
}
}
});
}
else {
$('homephotocaption').innerHTML = slides[idx].caption +  '<div class="photoBy">' + slides[idx].photog + '</div>';
if(slides[idx].caption != '' || slides[idx].photog != '') {
var ct = setTimeout(function(){
$('homephotocredits').appear({duration: .3});
},333);
}
}*/
},
updateDots: function(idx){
$$('#homeslidenavlinks .active').each(function(el){
el.className = '';
});
$('navlink' + idx).className = 'active';
},
loadVideo: function(el){
homeSlide.pause();
var videoLink = el.href,
parentEl = el.up(),
iframeCSS = '',
closeCSS = '',
videoWidth = el.getAttribute('data-video-width'),
videoHeight = el.getAttribute('data-video-height');
if(videoWidth != null){
var marginLeft = (videoWidth/2) * -1;
iframeCSS = 'width: ' + videoWidth + 'px; margin-left: ' + marginLeft + 'px; '
var closeMarginLeft = (marginLeft * -1) - 15;
closeCSS = 'margin-left: ' + closeMarginLeft + 'px; '
}
if(videoHeight != null){
var marginTop = (videoHeight/2) * -1;
iframeCSS = iframeCSS + 'height: ' + videoHeight + 'px; margin-top: ' + marginTop + 'px;'
var closeMarginTop = marginTop - 26;
closeCSS = closeCSS + 'margin-top: ' + closeMarginTop + 'px;';
}
if(iframeCSS != ''){
iframeCSS = 'style="' + iframeCSS +  '"';
closeCSS = 'style="' + closeCSS +  '"';
}
parentEl.insert({'bottom': '<div id="homevideowrap" onclick="homeSlide.unloadVideo(this);"><a href="#" id="homevidclose" ' + closeCSS + ' onclick="homeSlide.unloadVideo(this);" return false;"></a><iframe src="' + videoLink + '/player/cvp/init_autoplay/1" ' + iframeCSS + '  id="homevideoiframe" frameborder="0" scrolling="no"></iframe></div>'});
if(homeSlide.winHeight <= 768){
console.log('smaller: ' + homeSlide.winHeight);
$('homevideoiframe').addClassName('small');
$('homevidclose').addClassName('small');
}
},
unloadVideo: function(el){
el.remove();
},
imageLoading: function() {
homeSlide.loadedImages++;
if( homeSlide.loadedImages == homeSlide.totalSlides ) {
//start the slideshow.
if(homeSlide.totalSlides > 1) {
$('navarrowleft').style.display = 'block';
$('navarrowright').style.display = 'block';
$('homeslidenavlinks').appear();
homeSlide.t = setTimeout(function(){
if(homeSlide.version == 'touch') {
homeSlide.touch.slideshow();
}
else {
homeSlide.desktop.slideshow();
}
},homeSlide.firstInterval);
}
}
},
pause: function(){
clearTimeout(homeSlide.t);
homeSlide.playSlideshow = true;
},
cancel: function(){
clearTimeout(homeSlide.t);
homeSlide.playSlideshow = false;
},
prevNext: function(dir){
homeSlide.cancel();
if(homeSlide.version == 'touch') {
homeSlide.touch.prevNext(dir);
}
else {
homeSlide.desktop.slideTo(dir);
}
},
slideToPage: function(idx){
homeSlide.cancel();
if(homeSlide.version == 'touch') {
homeSlide.touch.slideToPage(idx);
}
else {
homeSlide.desktop.slideToPage(idx);
}
},
restart: function(){
if(homeSlide.playSlideshow){
homeSlide.t = setTimeout(function(){
if(homeSlide.version == 'touch') {
homeSlide.touch.slideshow();
}
else {
homeSlide.desktop.slideshow();
}
},homeSlide.interval);
}
},
setIEFooter: function(){
$('footer').style.position = 'relative';
$('homeslideposition').style.position = 'relative';
$('homeslideposition').style.marginBottom = '-29px';
},
desktop: {
init: function(){
$(document.body).addClassName('no-touch');
var totalSlides = slides.length;
if (totalSlides > 1) {
$('homeslidebox').insert({
'top': '<div class="homeslide" id="homeslideA">' + slides[totalSlides - 1].html + '</div>',
'bottom': '<div class="homeslide" id="homeslideC">' + slides[1].html + '</div>'
});
}
homeSlide.setup();
},
slideTo: function(dir, idx){
if(homeSlide.isSliding == false){
homeSlide.isSliding = true; //disabled double click
if(dir > 0){
homeSlide.currentPos++;
var moveDir = homeSlide.slideWidth * -1;
}
else {
homeSlide.currentPos--;
var moveDir = homeSlide.slideWidth;
}
if(idx != null) {
homeSlide.currentPos = idx;
}
if(homeSlide.currentPos >= slides.length){
// at the end go back to 0 index
homeSlide.currentPos = 0;
var prevHTML =  slides[slides.length - 1].html;
var currentHTML =  slides[homeSlide.currentPos].html;
var nextHTML =  slides[homeSlide.currentPos + 1].html;
}
if(homeSlide.currentPos == slides.length - 1 ){
// at the end load 0 index in next
var prevHTML =  slides[homeSlide.currentPos - 1].html;
var currentHTML =  slides[homeSlide.currentPos].html;
var nextHTML =  slides[0].html;
}
else
if(homeSlide.currentPos < 0){
//less than 0 index, go to last slide
homeSlide.currentPos = slides.length - 1;
var prevHTML =  slides[homeSlide.currentPos - 1].html;
var currentHTML =  slides[homeSlide.currentPos].html;
var nextHTML =  slides[0].html;
} else
if(homeSlide.currentPos == 0){
//Slide is now at 0 index
var prevHTML =  slides[slides.length - 1].html;
var currentHTML =  slides[homeSlide.currentPos].html;
var nextHTML =  slides[homeSlide.currentPos + 1].html;
}
else {
//default
var prevHTML =  slides[homeSlide.currentPos - 1].html;
var currentHTML =  slides[homeSlide.currentPos].html;
var nextHTML =  slides[homeSlide.currentPos + 1].html;
}
new Effect.Move('homeslidebox', {
x: moveDir,
y: 0,
mode: 'relative',
duration: homeSlide.duration,
afterFinish: function(){
//repage slides
$('homeslideB').innerHTML = currentHTML;
$('homeslidebox').style.left = '0px';
$('homeslideA').innerHTML = prevHTML;
$('homeslideC').innerHTML = nextHTML;
homeSlide.isSliding = false;
}
});
homeSlide.updateCaption(homeSlide.currentPos);
homeSlide.updateDots(homeSlide.currentPos);
} //end isSliding
}, //end slideTo
slideToPage: function(idx){
if(idx > homeSlide.currentPos) {
var dir = 1;
var nextDiv = 'homeslideC';
}
else
if(idx < homeSlide.currentPos) {
var dir = -1;
var nextDiv = 'homeslideA';
}
else {
return;
}
$(nextDiv).innerHTML = slides[idx].html;
homeSlide.desktop.slideTo(dir,idx);
},
slideshow: function(){
homeSlide.desktop.slideTo(1);
homeSlide.t = setTimeout(function(){homeSlide.desktop.slideshow();},homeSlide.interval);
}
},
touch: {
init: function(){
document.body.addClassName('touch');
$('homeslidewrapper').innerHTML = '';
homeSlide.setup();
homeSlide.touch.pagingIdx = null;
homeSlide.touch.directPage = false;
homeSlide.touch.gallery =  new SwipeView('#homeslidewrapper',
{
numberOfPages: slides.length,
hastyPageFlip: true,
snapThreshold: 10
}
);
var i,
page;
for (i=0; i<3; i++) {
page = i==0 ? slides.length-1 : i-1;
el = document.createElement('div');
el.innerHTML = slides[page].html;
homeSlide.touch.gallery.masterPages[i].appendChild(el)
}
homeSlide.touch.gallery.onFlip(function () {
var el,
upcoming,
i;
for (i=0; i<3; i++) {
upcoming = homeSlide.touch.gallery.masterPages[i].dataset.upcomingPageIndex;
if (upcoming != homeSlide.touch.gallery.masterPages[i].dataset.pageIndex) {
el = homeSlide.touch.gallery.masterPages[i]
el.innerHTML = slides[upcoming].html;
}
}
homeSlide.updateCaption(homeSlide.touch.gallery.pageIndex);
if(!homeSlide.touch.directPage) {
homeSlide.updateCaption(homeSlide.touch.gallery.pageIndex);
document.querySelector('#homeslidenavlinks .active').className = '';
$('navlink' + homeSlide.touch.gallery.pageIndex).className = 'active';
}
});
homeSlide.touch.gallery.onTouchStart(function () {
homeSlide.cancel();
});
document.getElementById('swipeview-slider').addEventListener('webkitTransitionEnd', function(){
if(homeSlide.touch.directPage){
homeSlide.touch.gallery.goToPage(homeSlide.touch.pagingIdx);
}
homeSlide.touch.directPage = false;
homeSlide.isSliding = false;
}, false);
}, //end init
prevNext: function(dir){
if(homeSlide.isSliding == false){
homeSlide.isSliding = false;
if(dir == -1){
homeSlide.touch.gallery.prev();
}
else {
homeSlide.touch.gallery.next();
}
}
},
slideToPage: function(idx) {
homeSlide.cancel();
var galleryIdx = homeSlide.touch.gallery.pageIndex;
if(galleryIdx != idx && homeSlide.isSliding == false) {
homeSlide.isSliding = true;
//set the goTo Idx so we can access it later
homeSlide.touch.pagingIdx = idx;
if(idx > galleryIdx) {
homeSlide.touch.gallery.next()
}
else
if(idx < galleryIdx){
homeSlide.touch.gallery.prev();
var nextDivIdx = 0;
}
else {
return;
}
document.querySelector('.swipeview-active').innerHTML = slides[idx].html;
homeSlide.touch.directPage = true;
homeSlide.updateDots(idx);
}
},
slideshow: function(){
homeSlide.touch.gallery.next();
homeSlide.t = setTimeout(function(){homeSlide.touch.slideshow();},homeSlide.interval);
}
}//end touch
}
if ("ontouchstart" in document.documentElement) {
window.scrollTo(0, 1);
homeSlide.version = 'touch';
}
else {
homeSlide.version = 'desktop';
}