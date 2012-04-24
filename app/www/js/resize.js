/* Sets the application display size. */
function setAppSize(w, h)
{
	var shepherd = document.getElementById("shepherd");
    shepherd.style.width= w + "px";
    shepherd.style.height = h + "px";

    var lassie = document.getElementById("lassie");
	lassie.style.width= w + "px";
    lassie.style.height = h + "px";
}