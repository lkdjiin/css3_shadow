
describe "BaseShadow", ->
  beforeEach ->
    @obj = new window.BaseShadow()

  describe "Sass output", ->
    it "should process 'transform'", ->
      expect(
        @obj.sass_code_for_transform("abc")
      ).toEqual("transform: abc\n")

    it "should process 'transform-origin'", ->
      expect(
        @obj.sass_code_for_transform_origin("abc")
      ).toEqual("transform-origin: abc\n")

  describe "CSS output", ->
    it "should process 'transform'", ->
      expect(
        @obj.css_code_for_transform("abc")
      ).toMatch("transform: abc;\n")

    it "should process 'transform-origin'", ->
      expect(
        @obj.css_code_for_transform_origin("abc")
      ).toMatch("transform-origin: abc;\n")

  describe "#setup_part", ->
    part = undefined
    beforeEach ->
      part = @obj.setup_part("Name", "blur", 10)

    it "should build the label as H2", -> expect(part).toMatch(/<h2>Name /)

    it "should build the property in a span", ->
      expect(part).toMatch(/<span id='value_blur'>10<\/span>/)

    it "should build the property in a div for the slider", ->
      expect(part).toMatch(/<div id='slider_blur'/)

