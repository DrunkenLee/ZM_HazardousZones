HazardousZones.Constants.EffectsData = {
    radiation = {
      minor = {
        exposureLimit = 100,
        moodles = {
          thirst = {
            chance = 5,
            value = 0.02
          },
          nausea = {
            chance = 1,
            bloodyCoughing = {
              chance = 0,
              value = 0
            }
          },
          pain = {
            chance = 5,
            value = 25, 
            bodyPart = "Head",
          },
        }
      },
      major = {
        exposureLimit = 300,
        moodles = {
          thirst = {
            chance = 10,
            value = 0.02
          },
          stress = {
            chance = 1,
            value = 0.26
          },
          nausea = {
            chance = 10,
            bloodyCoughing = {
              chance = 1,
              value = 5
            }
          },
          pain = {
            chance = 5,
            value = 20, 
            bodyPart = "random",
          },
        },
      },
      moderate = {
        exposureLimit = 600,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.02
          },
          stress = {
            chance = 5,
            value = 0.04
          },
          fatigue = {
            chance = 1,
            value = 0.02
          },
          disorientation = {
            chance = 1,
            value = 15
          },
          fear = {
            chance = 1,
            value = 0.15
          },
          panic = {
            chance = 1,
            value = 10
          },
          nausea = {
            chance = 20,
            bloodyCoughing = {
              chance = 5,
              value = 5
            }
          },
          pain = {
            chance = 10,
            value = 35, 
            bodyPart = "random",
          },
          bleeding = {
            chance = 1,
            value = 0.1,
            bodyPart = "random"
          }
        },
      },
      severe = {
        exposureLimit = 900,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.04
          },
          stress = {
            chance = 10,
            value = 0.06
          },
          fatigue = {
            chance = 5,
            value = 0.04
          },
          endurance = {
            chance = 1,
            value = -0.26
          },
          sanity = {
            chance = 1,
            value = -0.25
          },
          disorientation = {
            chance = 5,
            value = 1.5
          },
          fear = {
            chance = 5,
            value = 0.15
          },
          panic = {
            chance = 15,
            value = 10
          },
          anger = {
            chance = 1,
            value = 0.15
          },
          nausea = {
            chance = 50,
            bloodyCoughing = {
              chance = 10,
              value = 5
            }
          },
          pain = {
            chance = 20,
            value = 35, 
            bodyPart = "random",
          },
          burn = {
            chance = 1,
            value =0.2,
            bodyPart = "random"
          },
          bleeding = {
            chance = 10,
            value = 0.2,
            bodyPart = "random"
          }
        },
      },
      heavy = {
        exposureLimit = 1200,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.04
          },
          stress = {
            chance = 20,
            value = 0.08
          },
          fatigue = {
            chance = 10,
            value = 0.06
          },
          endurance = {
            chance = 10,
            value = -0.04
          },
          sanity = {
            chance = 25,
            value = -0.05
          },
          disorientation = {
            chance = 25,
            value = 2.5
          },
          fear = {
            chance = 5,
            value = 0.15
          },
          panic = {
            chance = 25,
            value = 10
          },
          anger = {
            chance = 25,
            value = 0.05
          },
          nausea = {
            chance = 70,
            bloodyCoughing = {
              chance = 20,
              value = 5
            }
          },
          pain = {
            chance = 25,
            value = 50, 
            bodyPart = "random",
          },
          burn = {
            chance = 5,
            value = 0.6,
            bodyPart = "random"
          },
          bleeding = {
            chance = 10,
            value = 0.3,
            bodyPart = "random"
          }
        },
      },
      deadly = {
        exposureLimit = 1800,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.04
          },
          stress = {
            chance = 50,
            value = 0.1
          },
          fatigue = {
            chance = 20,
            value = 0.1
          },
          endurance = {
            chance = 20,
            value = -0.1
          },
          sanity = {
            chance = 50,
            value = -0.1
          },
          disorientation = {
            chance = 50,
            value = 5
          },
          fear = {
            chance = 50,
            value = 0.3
          },
          panic = {
            chance = 50,
            value = 10
          },
          anger = {
            chance = 50,
            value = 0.1
          },
          nausea = {
            chance = 100,
            bloodyCoughing = {
              chance = 25,
              value = 10
            }
          },
          pain = {
            chance = 25,
            value = 100, 
            bodyPart = "random",
          },
          burn = {
            chance = 10,
            value = 1,
            bodyPart = "random"
          },
          bleeding = {
            chance = 15,
            value = 0.4,
            bodyPart = "random"
          },
          heartAttack = {
            chance = 100
          }
        },
      },
    },
    biological = {
      minor = {
        exposureLimit = 100,
        moodles = {
          thirst = {
            chance = 5,
            value = 0.02
          },
          nausea = {
            chance = 1,
            bloodyCoughing = {
              chance = 0,
              value = 0
            }
          },
          pain = {
            chance = 5,
            value = 25, 
            bodyPart = "Head",
          },
        }
      },
      major = {
        exposureLimit = 300,
        moodles = {
          thirst = {
            chance = 10,
            value = 0.02
          },
          stress = {
            chance = 1,
            value = 0.26
          },
          nausea = {
            chance = 10,
            bloodyCoughing = {
              chance = 1,
              value = 5
            }
          },
          pain = {
            chance = 5,
            value = 20, 
            bodyPart = "random",
          },
        },
      },
      moderate = {
        exposureLimit = 600,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.02
          },
          stress = {
            chance = 5,
            value = 0.04
          },
          fatigue = {
            chance = 1,
            value = 0.02
          },
          disorientation = {
            chance = 1,
            value = 15
          },
          fear = {
            chance = 1,
            value = 0.15
          },
          panic = {
            chance = 1,
            value = 10
          },
          nausea = {
            chance = 20,
            bloodyCoughing = {
              chance = 5,
              value = 5
            }
          },
          pain = {
            chance = 10,
            value = 35, 
            bodyPart = "random",
          },
          bleeding = {
            chance = 1,
            value = 0.1,
            bodyPart = "random"
          }
        },
      },
      severe = {
        exposureLimit = 900,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.04
          },
          stress = {
            chance = 10,
            value = 0.06
          },
          fatigue = {
            chance = 5,
            value = 0.04
          },
          endurance = {
            chance = 1,
            value = -0.26
          },
          sanity = {
            chance = 1,
            value = -0.25
          },
          disorientation = {
            chance = 5,
            value = 1.5
          },
          fear = {
            chance = 5,
            value = 0.15
          },
          panic = {
            chance = 15,
            value = 10
          },
          anger = {
            chance = 1,
            value = 0.15
          },
          nausea = {
            chance = 50,
            bloodyCoughing = {
              chance = 10,
              value = 5
            }
          },
          pain = {
            chance = 20,
            value = 35, 
            bodyPart = "random",
          },
          burn = {
            chance = 1,
            value =0.2,
            bodyPart = "random"
          },
          bleeding = {
            chance = 10,
            value = 0.2,
            bodyPart = "random"
          }
        },
      },
      heavy = {
        exposureLimit = 1200,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.04
          },
          stress = {
            chance = 20,
            value = 0.08
          },
          fatigue = {
            chance = 10,
            value = 0.06
          },
          endurance = {
            chance = 10,
            value = -0.04
          },
          sanity = {
            chance = 25,
            value = -0.05
          },
          disorientation = {
            chance = 25,
            value = 2.5
          },
          fear = {
            chance = 5,
            value = 0.15
          },
          panic = {
            chance = 25,
            value = 10
          },
          anger = {
            chance = 25,
            value = 0.05
          },
          nausea = {
            chance = 70,
            bloodyCoughing = {
              chance = 20,
              value = 5
            }
          },
          pain = {
            chance = 25,
            value = 50, 
            bodyPart = "random",
          },
          burn = {
            chance = 5,
            value = 0.6,
            bodyPart = "random"
          },
          bleeding = {
            chance = 10,
            value = 0.3,
            bodyPart = "random"
          }
        },
      },
      deadly = {
        exposureLimit = 1800,
        moodles = {
          thirst = {
            chance = 20,
            value = 0.04
          },
          stress = {
            chance = 50,
            value = 0.1
          },
          fatigue = {
            chance = 20,
            value = 0.1
          },
          endurance = {
            chance = 20,
            value = -0.1
          },
          sanity = {
            chance = 50,
            value = -0.1
          },
          disorientation = {
            chance = 50,
            value = 5
          },
          fear = {
            chance = 50,
            value = 0.3
          },
          panic = {
            chance = 50,
            value = 10
          },
          anger = {
            chance = 50,
            value = 0.1
          },
          nausea = {
            chance = 100,
            bloodyCoughing = {
              chance = 25,
              value = 10
            }
          },
          pain = {
            chance = 25,
            value = 100, 
            bodyPart = "random",
          },
          burn = {
            chance = 10,
            value = 1,
            bodyPart = "random"
          },
          bleeding = {
            chance = 15,
            value = 0.4,
            bodyPart = "random"
          },
          heartAttack = {
            chance = 100
          }
        },
      },
    },
  }