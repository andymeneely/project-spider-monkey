module SvgEffects
  def drawing game_icon
    doc = Nokogiri::XML(GameIcons.get(game_icon).string)
    doc.at_css('svg').children.first.add_previous_sibling SvgEffects.filters
    # doc.css('svg')[0]['width'] = 530
    # doc.css('svg')[0]['height'] = 530
    doc.css('svg')[0]['viewBox'] = '0 0 518 518'
    doc.css('path')[0]['fill-opacity'] = 0.0

    # Duplicate the lineart
    doc.at_css('svg').add_child doc.css('path')[1].dup

    # Color it, no stroke
    doc.css('path')[1]['fill'] = '#9B876C' # solid fill
    # doc.css('path')[1]['fill'] = 'url(#diagonalHatches)'
    doc.css('path')[1]['fill-opacity'] = 0.0
    doc.css('path')[1]['stroke-opacity'] = 0.0 # hide it all
    doc.css('path')[1]['stroke-width'] = 0
    doc.css('path')[1]['stroke'] = '#42321b'
    # doc.css('path')[1]['style'] = 'filter:url(#lapping);'

    # Make a sketchy stroke
    # doc.css('path')[2]['fill'] = '#fff'
    doc.css('path')[2]['fill'] = 'url(#diagonalHatches)'
    doc.css('path')[2]['fill-opacity'] = 0.0
    doc.css('path')[2]['stroke-width'] = 6
    # doc.css('path')[2]['stroke'] = '#000'
    doc.css('path')[2]['stroke'] = '#42321b' # blueprint white
    # doc.css('path')[1]['stroke-opacity'] = 0.7
    doc.css('path')[2]['style'] = 'filter:url(#lapping);'

    return doc.to_xml
  end
  module_function :drawing

  def filters
    <<-EOS
    <defs>
      <filter
         inkscape:label="Lapping"
         inkscape:menu="Distort"
         inkscape:menu-tooltip="Something like a water noise"
         height="1.4"
         y="-0.25"
         width="1.4"
         x="-0.25"
         color-interpolation-filters="sRGB"
         id="lapping">
        <feTurbulence
           numOctaves="2"
           seed="150"
           type="fractalNoise"
           baseFrequency="0.0040000000000000001"
           result="result1"
           id="feTurbulence6110" />
        <feGaussianBlur
           stdDeviation="1"
           result="result2"
           id="feGaussianBlur6112" />
        <feDisplacementMap
           scale="50"
           yChannelSelector="B"
           xChannelSelector="R"
           in="SourceGraphic"
           in2="result2"
           id="feDisplacementMap6114" />
      </filter>
      <pattern
        id="diagonalHatches"
        patternTransform="translate(0,0) scale(5,5)"
        height="4"
        width="4"
        patternUnits="userSpaceOnUse">
        <line
          x1="-1"
          y1="0"
          x2="0"
          y2="-1"
          style="stroke:#28221b;stroke-width:0.25" />
        <line
          x1="0"
          y1="3"
          x2="3"
          y2="0"
          style="stroke:#28221b;stroke-width:0.25" />
        <line
          x1="2"
          y1="5"
          x2="7"
          y2="0"
          style="stroke:#28221b;stroke-width:0.25" />
       </pattern>
    </defs>
    EOS
  end
  module_function :filters

end
