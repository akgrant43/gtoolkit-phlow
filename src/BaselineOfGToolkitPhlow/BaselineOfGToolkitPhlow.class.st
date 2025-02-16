"
!Phlow

Phlow is a generic browsing engine for specifying views and transmissions. It is primarily used for defining inspector extensions (see ${class:BaselineOfGToolkitInspector}$).

!!Views

Views define the logic through which the concrete widgets get built. They are essentially stencils.

See ${class:GtPhlowViewExamples}$.

!!Actions

Views have actions.

See ${class:GtPhlowActionExamples}$


"
Class {
	#name : #BaselineOfGToolkitPhlow,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPhlow
}

{ #category : #baseline }
BaselineOfGToolkitPhlow >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick/src' ].
		spec baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ].
		spec package: 'GToolkit-Phlow' with: [
				spec requires: #(#Brick 'GToolkitUtility'). ]. ].

]
