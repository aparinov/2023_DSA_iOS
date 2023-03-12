from rest_framework import generics, permissions
from server.serializers import *
from server.permissions import IsOwner


class ProjectList(generics.ListAPIView):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer
    permission_classes = [permissions.IsAuthenticated]


class ProjectCreate(generics.CreateAPIView):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer
    permission_classes = [permissions.IsAdminUser]


class ProjectView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer
    permission_classes = [permissions.IsAdminUser]


class ApplicationsList(generics.ListCreateAPIView):
    queryset = Applications.objects.all()
    serializer_class = ApplicationsSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(student=self.request.user)


class ApplicationsView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Applications.objects.all()
    serializer_class = Applications
    permission_classes = [permissions.IsAdminUser]


class TechnicalRequirementsList(generics.ListCreateAPIView):
    queryset = TechnicalRequirements.objects.all()
    serializer_class = TechnicalRequirementsSerializer
    permission_classes = [permissions.IsAdminUser]


class TechnicalRequirementsView(generics.RetrieveUpdateDestroyAPIView):
    queryset = TechnicalRequirements.objects.all()
    serializer_class = TechnicalRequirementsSerializer
    permission_classes = [permissions.IsAdminUser]


class TechStackList(generics.ListCreateAPIView):
    queryset = TechStack.objects.all()
    serializer_class = TechStackSerializer
    permission_classes = [permissions.IsAdminUser]


class TechStackView(generics.RetrieveUpdateDestroyAPIView):
    queryset = TechStack.objects.all()
    serializer_class = TechStackSerializer
    permission_classes = [permissions.IsAdminUser]


class StudentInformationList(generics.ListAPIView):
    queryset = StudentInformation.objects.all()
    serializer_class = StudentInformationSerializer
    permission_classes = [permissions.IsAdminUser]


class StudentInformationCreate(generics.CreateAPIView):
    queryset = StudentInformation.objects.all()
    serializer_class = StudentInformationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(student=self.request.user)


class StudentInformationView(generics.RetrieveUpdateDestroyAPIView):
    queryset = StudentInformation.objects.all()
    serializer_class = StudentInformationSerializer
    permission_classes = [IsOwner | permissions.IsAdminUser]


class StudentsInterestsList(generics.ListCreateAPIView):
    serializer_class = StudentsInterestsSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(student=self.request.user)

    def get_queryset(self):
        return StudentsInterests.objects.filter(student=self.request.user)


class StudentsInterestsView(generics.RetrieveUpdateDestroyAPIView):
    queryset = StudentsInterests.objects.all()
    serializer_class = StudentsInterestsSerializer
    permission_classes = [IsOwner | permissions.IsAdminUser]


class InterestList(generics.ListCreateAPIView):
    queryset = Interest.objects.all()
    serializer_class = InterestSerializer
    permission_classes = [permissions.IsAdminUser]


class InterestView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Interest.objects.all()
    serializer_class = InterestSerializer
    permission_classes = [permissions.IsAdminUser]
