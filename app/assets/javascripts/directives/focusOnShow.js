// Credit
// https://github.com/ucdavis/Instructional-Planning-and-Administration/blob/master/source/production/webapp/assets/js/app/modules/shared/directives/focusOnShow.js
Chekhov.directive("focusOnShow", this.focusOnShow = function($timeout) {
	return function(scope, element, attrs) {
		// Case 1: using ng-if
		$timeout(function() {
			element.focus();
		});

		// Case 2: using ng-show
		scope.$watch(attrs.ngShow, function (newValue) {
			$timeout(function() {
				newValue && element.focus();
			});
		},true);
	};
})
