import QtQuick 2.0
import QtQuick.Particles 2.0

/**
 * ParticleSystem component draw particles with the given color. The
 * location of the particles depends on the given TouchPoint 'point'.
 */

ParticleSystem {
    id: root
    anchors.fill: parent
    running: true

    property color particleColor: "#ff0000"
    property TouchPoint point: null;
    property int angle: 0
    property int pointCount: 0
    property int startAngle: 0
    property real radius: 0
    property int movement: 1
    property real targetX: root.point.pressed ? root.point.x : width/2+radius * Math.cos(targetAngle*(Math.PI/180))
    property real targetY: root.point.pressed ? root.point.y : height/2+radius * Math.sin(targetAngle*(Math.PI/180))
    property real targetAngle: angle+startAngle
    property bool emitting: false

    Emitter {
        id: emitter
        lifeSpan: 1000
        emitRate: 80
        x: targetX
        y: targetY
        enabled: root.emitting
        size: root.height*.05
        endSize: root.height*.1
        sizeVariation: .5
        velocity: AngleDirection{angle:0; angleVariation: 360; magnitude: 10}
        acceleration: AngleDirection{angle:0; angleVariation: 360; magnitude: 10}
        velocityFromMovement: root.movement
    }

    ImageParticle {
        id: imageParticle
        source: "images/particle.png"
        color: root.pointCount >0 && root.point.pressed ? root.particleColor: "#444444"
        alpha: .0
        colorVariation: root.pointCount >0 && root.point.pressed  ? 0.3: .0

        Behavior on color{
            enabled: root.pointCount != 0
            ColorAnimation { duration: 500 }
        }

        SequentialAnimation on color {
            id: colorAnimation
            loops: Animation.Infinite
            running: root.pointCount === 0
            ColorAnimation {from: root.particleColor; to: "magenta";  duration: 2000}
            ColorAnimation {from: "magenta"; to: "blue"; duration: 1000}
            ColorAnimation {from: "blue"; to: "violet";  duration: 1000}
            ColorAnimation {from: "violet"; to: "red";  duration: 1000}
            ColorAnimation {from: "red"; to: "orange";  duration: 1000}
            ColorAnimation {from: "orange"; to: "yellow";  duration: 1000}
            ColorAnimation {from: "yellow"; to: "green";  duration: 1000}
            ColorAnimation {from: "green"; to: root.particleColor; duration: 2000}
        }
    }
}
