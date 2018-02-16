from django.db import models
from apps.base.models import User, SoftDeleteTSModel, DescriptiveModel
from apps.core.models import Indicator, Program, Subject
from apps.business.models import Campus, Period, Survey


class Course(SoftDeleteTSModel, DescriptiveModel):
    section = models.CharField(max_length=250, verbose_name='Sección')

    checksum = models.CharField(blank=True, max_length=100)

    teachers = models.ManyToManyField(User, related_name='teachers')
    students = models.ManyToManyField(User, related_name='students')

    period = models.ForeignKey(Period, on_delete=models.CASCADE,)
    campus = models.ForeignKey(Campus, on_delete=models.CASCADE,)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE,)
    survey = models.ForeignKey(Survey, on_delete=models.CASCADE,)


class FinalNoteEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    teacher = models.ForeignKey(User, on_delete=models.CASCADE, related_name='teacher')
    student = models.ForeignKey(User, on_delete=models.CASCADE, related_name='student')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)


class TempNoteEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    final_note_evaluation = models.ForeignKey(
        FinalNoteEvaluation,
        on_delete=models.CASCADE,
    )


class FinalIndicatorEvaluation(SoftDeleteTSModel):
    value = models.FloatField()

    fedback = models.TextField()
    fedback_score = models.FloatField()

    teacher = models.ForeignKey(User, on_delete=models.CASCADE, related_name='eval_teacher')
    student = models.ForeignKey(User, on_delete=models.CASCADE, related_name='eval_student')
    course = models.ForeignKey(Course, on_delete=models.CASCADE,)


class TempFinalIndicatorEvaluation(SoftDeleteTSModel):
    value = models.FloatField()
    final_note_evaluation = models.ForeignKey(
        FinalNoteEvaluation,
        on_delete=models.CASCADE,
    )
