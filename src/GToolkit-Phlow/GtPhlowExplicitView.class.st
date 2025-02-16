"
I represent an explicit view. I am typically used for describing a view of an object.

I decorate a ==stencilBuilder== with extra information, such as ==title==. The ==stencilBuilder== is responsible for creating the contents of the view. The extra information is meant to create the decoration around that content.

For example, a view of an object can be a visualization with the title being Visualization. A typical application is to add this view to a tab group. As we want to be able to create the content lazily, for example because it might be expensive, we need to know the title before the content is created. To this end, we have the title separate from the stencil builder.
"
Class {
	#name : #GtPhlowExplicitView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowExplicitView >> asElementDo: aBlock [
	| element |
	self assert: stencilBuilder notNil description: 'The stencil should be initialized'.
	element := [ stencilBuilder asElement ] 
		on: Error 
		do: [:error | 
			error freeze.
			GtPhlowViewWithError new error: error; asElementDo: [ :errorElement | errorElement ] ].
	element phlow beView; entity: self.
	^ aBlock value: element.
]

{ #category : #accessing }
GtPhlowExplicitView >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #accessing }
GtPhlowExplicitView >> stencilBuilder [
	^ stencilBuilder
]

{ #category : #updating }
GtPhlowExplicitView >> updateContent: anElement [
	"anElement is previsously computed content from asElementDo:"
	
	self asElementDo: [ :aNewElement | 
		| aParent |
		aParent := anElement parent.
		aNewElement phlow beViewContent; entity: self.
		aParent replaceChild: anElement with: aNewElement ].
	
]
