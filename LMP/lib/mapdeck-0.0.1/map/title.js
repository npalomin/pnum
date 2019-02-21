function add_title(map_id, layer_id, title_data) {

    'use strict';

    console.log( title_data );

    var title,
        style = '',
        isUpdating = false;

    if (window[map_id + 'mapTitle' + layer_id] == null) {
        window[map_id + 'mapTitle' + layer_id] = document.createElement("div");
    }
    window[map_id + 'mapTitle' + layer_id].setAttribute('id', map_id + 'mapTitle' + layer_id);
    window[map_id + 'mapTitle' + layer_id].setAttribute('class', 'mapTitle');
    window[map_id + 'mapTitle' + layer_id].innerHTML = title_data.title;


    if (title_data.css !== null) {
    	  console.log( window[map_id + 'mapTitle' + layer_id] );
        window[map_id + 'mapTitle' + layer_id].setAttribute('style', title_data.css);
    }

    if (isUpdating === false) {
        placeTitle(map_id, window[map_id + 'mapTitle' + layer_id], title_data.position);
    }
}


function clear_title( map_id, layer_id ) {
	/*
	// find reference to this layer in the legends
	var id = map_id + 'mapTitle' + layer_id;
	var objIndex = md_find_by_id( window[map_id + 'mapTitle'], id, "index" );

	if( objIndex !== undefined ) {
		md_removeControl( map_id, id, window[map_id + 'mapTitle' + layer_id][objIndex].position );
		window[map_id + 'mapTitle' + layer_id].splice(objIndex, 1);
	  window[id] = null;
	}
	*/

	var element = document.getElementById( map_id + 'mapTitle' + layer_id );
	element.parentNode.removeChild( element );
}


function placeTitle( map_id, object, position ) {

    var mapbox_ctrl = document.getElementById( "mapTitleContainer"+map_id);
    mapbox_ctrl.appendChild( object );

/*
    var title = {};
    var position = "TOP_LEFT";

    title = {
        id: object.getAttribute('id'),
        position: position
    };

    window[map_id + 'mapTitlePositions'].push( title );
*/
}


