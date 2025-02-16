"
I offer the Phlow navigation API over the Bloc element tree starting with the specific element I am tied with.
"
Class {
	#name : #GtPhlowElementContext,
	#superclass : #Object,
	#instVars : [
		'element',
		'isView',
		'isAction',
		'isViewContent',
		'entity',
		'isPopupContainer'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #'instance creation' }
GtPhlowElementContext class >> on: anElement [
	^ self new element: anElement
]

{ #category : #'api - search' }
GtPhlowElementContext >> allChildrenWithView [
	<return: #Array of: #BrTab>
	| aTab |
	aTab := self firstChildWithView.
	aTab ifNil: [ ^ #() ].
	^ aTab parent children select: [ :child | child phlow isView ]
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> beAction [
	isAction := true
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> bePopupContainer [
	isPopupContainer := true
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> beView [
	isView := true
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> beViewContent [
	isViewContent := true
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> element [
	^ element
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> element: anObject [
	element := anObject
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> entity [
	^ entity
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> entity: anObject [
	entity := anObject
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeView [
	^ self firstChildWithCompositeViewDo: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeViewDo: aBlock [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | 
			child phlow isView and: [ child phlow entity isKindOf: GtPhlowCompositeView ] ] 
		ifFound: aBlock
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithView [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child phlow isView ] 
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstParentWithView [
	^ self element 
		allParentsDetect: [ :parent | parent phlow isView ] 
		ifFound: [ :parent | parent ]
		ifNone: [ "nothing" ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstPopupContainerParentDo: aBlock ifNone: aNoneBlock [
	self element withAllParentsDo: [ :aParentElement |
			aParentElement phlow isPopupContainer ifTrue: [ ^ aBlock value: aParentElement ] ].
		
	^ aNoneBlock value
]

{ #category : #initialization }
GtPhlowElementContext >> initialize [
	super initialize.
	
	isAction := false.
	isView := false.
	isViewContent := false.
	isPopupContainer := false.
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isAction [
	^ isAction
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isPopupContainer [
	^ isPopupContainer
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isView [
	^ isView
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isViewContent [
	^ isViewContent
]

{ #category : #events }
GtPhlowElementContext >> selectObject: anObject [
	self element fireEvent: (GtPhlowObjectToSelect new
		object: anObject;
		sourceElement: self element) 
]

{ #category : #events }
GtPhlowElementContext >> spawnObject: anObject [
	self element fireEvent: (GtPhlowObjectToSpawn new
		object: anObject;
		sourceElement: self element) 
]

{ #category : #'api - search' }
GtPhlowElementContext >> textViewContent [
	self assert: [ self isAction ].
	^ self viewContent
		allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrEditorElement ] 
		ifFound: [:editorElement | editorElement editor text ]
]

{ #category : #updating }
GtPhlowElementContext >> update [
	self entity updateContent: self element.
]

{ #category : #'api - search' }
GtPhlowElementContext >> viewContent [
	self assert: [ self isAction ].
	^ self firstParentWithView phlow firstChildWithView parentTabGroup content
]
