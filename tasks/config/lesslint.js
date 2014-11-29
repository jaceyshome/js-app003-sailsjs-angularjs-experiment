module.exports = function(grunt) {
  grunt.config.set("lesslint", {
    src: ["src/frontend/src.less"],
    options: {
      imports: ["src/frontend/**/*.less"],
      csslint: {
        "unqualified-attributes": false,
        "adjoining-classes": false,
        "qualified-headings": false,
        "unique-headings": false,
        "ids": false,
        "overqualified-elements": false,
        "box-sizing": false
      }
    }
  });
  grunt.loadNpmTasks("grunt-lesslint");
};

//# sourceMappingURL=lesslint.js.map
