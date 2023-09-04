from django.db import models

# Create your models here.


class Blog(models.Model):
    titre = models.CharField(max_length=200)
    description = models.TextField()
    image = models.ImageField(upload_to='images/')
    # auteur = models.ForeignKey('auth.User', on_delete=models.CASCADE)

    def __str__(self):
        return self.titre
    class Meta:
        ordering = ["-id"]
