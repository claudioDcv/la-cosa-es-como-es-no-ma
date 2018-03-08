from django.db import models
from apps.base.models import User, SoftDeleteTSModel, DescriptiveModel
from apps.core.models import Indicator, Program, Subject
from apps.business.models import Campus, Period, Survey


class Course(SoftDeleteTSModel, DescriptiveModel):
    section = models.CharField(max_length=250, verbose_name='Sección')

    checksum = models.CharField(blank=True, max_length=100)

    teachers = models.ManyToManyField(
        User,
        related_name='teachers',
        # limit_choices_to={
        #     'id__in':User._product_list,
        # },
    )
    students = models.ManyToManyField(User, related_name='students')

    period = models.ForeignKey(Period, on_delete=models.CASCADE,)
    campus = models.ForeignKey(Campus, on_delete=models.CASCADE,)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE,)
    survey = models.ForeignKey(Survey, on_delete=models.CASCADE,)


class Feedback(SoftDeleteTSModel):
    score = models.FloatField(blank=True, null=True)
    message = models.TextField(max_length=500, verbose_name='Mensaje')
    evaluator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedback_evaluator')
    evaluated = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedback_evaluated')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)


class TempFeedbackMessage(SoftDeleteTSModel):
    message = models.TextField(max_length=500, verbose_name='Mensaje')
    feedback = models.ForeignKey(Feedback, on_delete=models.CASCADE,)


class TempFedbackScore(SoftDeleteTSModel):
    score = models.FloatField(blank=True, null=True)
    feedback = models.ForeignKey(Feedback, on_delete=models.CASCADE,)


class FinalScoreEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    evaluator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='note_evaluator')
    evaluated = models.ForeignKey(User, on_delete=models.CASCADE, related_name='note_evaluated')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)


class TempScoreEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    final_note_evaluation = models.ForeignKey(
        FinalScoreEvaluation,
        on_delete=models.CASCADE,
    )


class FinalIndicatorEvaluation(SoftDeleteTSModel):
    value = models.FloatField()

    evaluator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='evaluator')
    evaluated = models.ForeignKey(User, on_delete=models.CASCADE, related_name='evalueted')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)
    indicator = models.ForeignKey(Indicator, on_delete=models.CASCADE,)

    class Meta:
        unique_together = (('indicator', 'course', 'evaluated'),)


class TempFinalIndicatorEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    final_indicator_evaluation = models.ForeignKey(
        FinalIndicatorEvaluation,
        on_delete=models.CASCADE,
    )
