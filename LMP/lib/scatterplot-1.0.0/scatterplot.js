

function add_scatterplot_geo( map_id, scatter_data, layer_id, auto_highlight, highlight_colour, legend, bbox, update_view, focus_layer, js_transition ) {

  const scatterLayer = new ScatterplotLayer({
    map_id: map_id,
    id: 'scatterplot-'+layer_id,
    data: scatter_data,
    radiusScale: 1,
    radiusMinPixels: 1,
    stroked: true,  // TODO( make conditional IFF stroke provided?)
    filled: true,
    getRadius: d => d.properties.radius,
    getPosition: d => md_get_point_coordinates( d ),
    getFillColor: d => md_hexToRGBA( d.properties.fill_colour ),
    getLineColor: d => md_hexToRGBA( d.properties.stroke_colour ),
    getLineWidth: d => d.properties.stroke_width,
    pickable: true,
    autoHighlight: auto_highlight,
    highlightColor: md_hexToRGBA( highlight_colour ),
    onClick: info => md_layer_click( map_id, "scatterplot", info ),
    onHover: md_update_tooltip,
    transitions: js_transition || {}
  });
  md_update_layer( map_id, 'scatterplot-'+layer_id, scatterLayer );

  if (legend !== false) {
    add_legend(map_id, layer_id, legend);
  }
  md_layer_view( map_id, layer_id, focus_layer, bbox, update_view );
}

function add_scatterplot_polyline( map_id, scatter_data, layer_id, auto_highlight, highlight_colour, legend, bbox, update_view, focus_layer, js_transition ) {

  const scatterLayer = new ScatterplotLayer({
    map_id: map_id,
    id: 'scatterplot-'+layer_id,
    data: scatter_data,
    radiusScale: 1,
    radiusMinPixels: 1,
    stroked: true,
    filled: true,
    getRadius: d => d.radius,
    getPosition: d => md_decode_points( d.polyline ),
    getFillColor: d => md_hexToRGBA( d.fill_colour ),
    getLineColor: d => md_hexToRGBA( d.stroke_colour ),
    getLineWidth: d => d.stroke_width,
    pickable: true,
    autoHighlight: auto_highlight,
    highlightColor: md_hexToRGBA( highlight_colour ),
    onClick: info => md_layer_click( map_id, "scatterplot", info ),
    onHover: md_update_tooltip,
    transitions: js_transition || {}
  });
  md_update_layer( map_id, 'scatterplot-'+layer_id, scatterLayer );

  if (legend !== false) {
    add_legend(map_id, layer_id, legend);
  }
  md_layer_view( map_id, layer_id, focus_layer, bbox, update_view );
}
