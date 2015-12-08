<?php
namespace Smichaelsen\Gist\Service;

use TYPO3\CMS\Extbase\DomainObject\DomainObjectInterface;
use TYPO3\CMS\Extbase\Error\Result;
use TYPO3\CMS\Extbase\Validation\Validator\ConjunctionValidator;
use TYPO3\CMS\Extbase\Validation\Validator\ValidatorInterface;

/**
 * Provides stand alone validation for domain objects.
 *
 * Additionally it adds the possibility to define validators via object class phpdoc annotations
 */
class ValidationService
{

    /**
     * @var \TYPO3\CMS\Extbase\Reflection\ReflectionService
     * @inject
     */
    protected $reflectionService;

    /**
     * @var \TYPO3\CMS\Extbase\Validation\ValidatorResolver
     * @inject
     */
    protected $validatorResolver;

    /**
     * @param DomainObjectInterface $object
     * @return Result
     */
    public function validate(DomainObjectInterface $object) {
        $validator = $this->validatorResolver->getBaseValidatorConjunction(get_class($object));
        $validator->addValidator($this->getCustomObjectValidator($object));
        return $validator->validate($object);
    }

    /**
     * @param DomainObjectInterface $object
     * @return ValidatorInterface
     */
    protected function getCustomObjectValidator(DomainObjectInterface $object) {
        $conjunctionValidator = new ConjunctionValidator();
        foreach ($this->reflectionService->getClassTagValues(get_class($object), 'validate') as $validatorClassName) {
            $conjunctionValidator->addValidator($this->validatorResolver->createValidator($validatorClassName));
        }
        return $conjunctionValidator;
    }

}
