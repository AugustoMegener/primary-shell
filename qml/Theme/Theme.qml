pragma Singleton
import QtQuick

QtObject {
    readonly property color transparent: "#00000000"
    readonly property string innershadowShader: "assets/shaders/innershadow.frag.qsb"
    readonly property color accent: "#da9a22"
    readonly property color background: "#2b2622"
    readonly property color foreground: "#302b24"
    readonly property color dim: "#866f51"
    readonly property int fontSize: 14

     property var altColor: function(i) {
      const colors = ["#da9a22", "#f25146", "#4396b7"]
      if (i === 0)
      return "#4b4db8"
      return colors[(i - 1) % 3]
    }

     property var altIcon: function(i) {
      const icons = [ "circle", "triangle", "square"  ]
      return "assets/icons/" + ((i === 0) ? "astroid" : icons[(i - 1) % 3]) + ".svg"
    }
}
