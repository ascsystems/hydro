# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$j = jQuery.noConflict();
$j ->
  $j("a#form_handle").bind "click", (e) ->
    e.preventDefault()
    $j('form#new_order').submit()


