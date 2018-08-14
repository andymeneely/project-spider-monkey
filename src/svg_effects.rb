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
    doc.css('path')[1]['fill'] = '#9B876C'
    doc.css('path')[1]['fill-opacity'] = 1.0
    doc.css('path')[1]['stroke-width'] = 0
    doc.css('path')[1]['stroke'] = '#9B876C'
    doc.css('path')[1]['style'] = 'filter:url(#lapping);'

    # Make a sketchy stroke
    doc.css('path')[2]['fill'] = '#fff'
    doc.css('path')[2]['fill-opacity'] = 0.0
    doc.css('path')[2]['stroke-width'] = 6
    doc.css('path')[2]['stroke'] = '#000'
    # doc.css('path')[1]['stroke-opacity'] = 0.7
    doc.css('path')[2]['style'] = 'filter:url(#lapping);'

    return doc.to_xml
  end
  module_function :drawing

  def filters
    <<-EOS
    <defs id="defs5403">
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
           numOctaves="3"
           seed="150"
           type="fractalNoise"
           baseFrequency="0.0040000000000000001"
           result="result1"
           id="feTurbulence6110" />
        <feGaussianBlur
           stdDeviation="2"
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
    </defs>
    EOS
  end
  module_function :filters

end
